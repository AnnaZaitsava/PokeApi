////
////  MainScreenViewController.swift
////  PokeApi Innowise
////
////  Created by Anna Zaitsava on 17.02.24.
//
import UIKit


protocol MainDisplayLogic: AnyObject {
    func updatePokemonList(viewModel: Main.displayPokemons.ViewModel)
}

class MainViewController: UIViewController, MainDisplayLogic {
    
    // MARK: variables
    
    var interactor: MainLogic?
    var router: (NSObjectProtocol & MainRoutingLogic & MainDataPassing)?
    
    // MARK: Class variables
    
    private lazy var mainTable = UITableView()
    private lazy var pokemons: [Main.displayPokemons.ViewModel.pokemonList] = []
    
    // MARK: Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavBar()
        setupConstraints()
        mainTableSetup()
        requestList()
    }
    
    // MARK: Class functions
    
    private func requestList() {
        let request = Main.displayPokemons.Request()
        interactor?.fetchPokemons(request: request)
    }
    
    func updatePokemonList(viewModel: Main.displayPokemons.ViewModel) {
        let pokemonList = viewModel.pokemonListViewModel
        self.pokemons = pokemonList
        mainTable.reloadData()
    }
    
    // MARK: Setup
    
    private func setup() {
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
    
    private func mainTableSetup() {
        mainTable.delegate = self
        mainTable.dataSource = self
        mainTable.register(
            MainScreenCell.self,
            forCellReuseIdentifier: MainScreenCell.identifier)
        mainTable.separatorStyle = .none
        mainTable.backgroundColor = .clear
    }
    
    private func setupNavBar() {
        self.navigationItem.title = "Pokemons"
    }
    
    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubviews(mainTable)
        NSLayoutConstraint.activate([
            mainTable.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0),
            mainTable.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0),
            mainTable.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0),
            mainTable.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0)
        ])
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
