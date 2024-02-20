//
//  MainScreenViewController.swift
//  PokeApi Innowise
//
//  Created by Anna Zaitsava on 17.02.24.

import UIKit


protocol MainDisplayLogic: AnyObject {
    func displayPokemonList(viewModel: MainScreenDataFlow.Pokemons.ViewModel)
}

class MainViewController: UIViewController {
    
    // MARK: Variables
    
    var interactor: MainLogic?
    var router: (NSObjectProtocol & MainRoutingLogic & MainDataPassing)?
    
    // MARK: Class variables
    
    private lazy var mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            MainScreenCell.self,
            forCellReuseIdentifier: MainScreenCell.identifier
        )
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.refreshControl = UIRefreshControl(frame: .zero, primaryAction: UIAction { [weak self] _ in
            self?.didPullToRefresh()
        })
        tableView.refreshControl?.layer.zPosition = -1
        return tableView
    }()
    
    private var pokemons: [MainScreenDataFlow.Pokemons.ViewModel.PokemonList] = []
    
    // MARK: Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupNavBar()
        build()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        build()
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        makeConstraints()
        requestList()
        setupNavBar()
    }
}

// MARK: MainDisplayLogic

extension MainViewController: MainDisplayLogic {
    func displayPokemonList(viewModel: MainScreenDataFlow.Pokemons.ViewModel) {
        let pokemonList = viewModel.pokemonListViewModel
        pokemons = pokemonList
        mainTableView.reloadData()
        mainTableView.refreshControl?.endRefreshing()
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == pokemons.count - 1 {
            requestList()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print ("\(pokemons[indexPath.row])")
        interactor?.saveSelectedItem(pokemon: pokemons[indexPath.row])
        router?.routeToDetailedViewController()
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonListCell") as? MainScreenCell
        cell?.configureCell(withName: pokemons[indexPath.row].name)
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

// MARK: - Private methods

private extension MainViewController {
    func requestList() {
        let request = MainScreenDataFlow.Pokemons.Request()
        interactor?.fetchPokemons(request: request)
    }
    
    func build() {
        let viewController = self
        let interactor = MainInteractor()
        let presenter = MainPresenter()
        let router = MainRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    func setupNavBar() {
        self.navigationItem.title = "Pokemons"
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.black,
                NSAttributedString.Key.font: UIFont.bold30() ?? .systemFont(ofSize: 30)
            ]
        }

        // Создание изображения для кнопки "Назад"
        let backButtonImage = UIImage(systemName: "arrow.left")
        
        // Настройка цвета кнопки "Назад" на всех предыдущих экранах
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.layoutMargins = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)

        // Установка изображения для кнопки "Назад" на всех предыдущих экранах
        navigationController?.navigationBar.backIndicatorImage = backButtonImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
        

        // Удаление текста с кнопки "Назад" на текущем экране
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    
    func addSubviews() {
        view.addSubviews(mainTableView)
    }
    
    func makeConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            mainTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    func didPullToRefresh() {
        requestList()
    }
}
