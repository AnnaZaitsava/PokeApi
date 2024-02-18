//
//  DetailsScreenViewController.swift
//  PokeApi Innowise
//
//  Created by Anna Zaitsava on 17.02.24.


import UIKit

protocol DetailsDisplayLogic: AnyObject {
    func updateData(viewModel: Details.displayDetailedInformation.ViewModel)
}

class DetailsScreenViewController: UIViewController, DetailsDisplayLogic {
    
    // MARK: variables
    
    var interactor: DetailedBusinessLogic?
    var router: (NSObjectProtocol & DetailedRoutingLogic & DetailedDataPassing)?
    
    private lazy var  bgView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "bg")
        return view
    }()
    
    private lazy var pokemonImage: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var typeLabel = UILabel(text: "Type", textColor: .black)
    private lazy var weightLabel = UILabel(text: "Weight", textColor: .black)
    private lazy var heightLabel = UILabel(text: "Height", textColor: .black)
    
    private lazy var typeBg = UIView.makeBgView(bgColor: .white)
    private lazy var weightBg = UIView.makeBgView(bgColor: .white)
    private lazy var heightBg = UIView.makeBgView(bgColor: .white)
    
    private lazy var typeValue = UILabel(text: "Type",
                                         font: .medium18(),
                                         textColor: .black)
    private lazy var weightValue = UILabel(text: "Weight",
                                           font: .medium18(),
                                           textColor: .black)
    private lazy var heightValue = UILabel(text: "Height",
                                           font: .medium18(),
                                           textColor: .black)
    
    // MARK: Initialization
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = DetailsScreenInteractor()
        let presenter = DetailsScreenPresenter()
        let router = DetailsScreenRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        showDetailedCharacterInformation()
    }
    
    func showDetailedCharacterInformation() {
        interactor?.fetchDetailedInformation()
    }
    
    func updateData(viewModel: Details.displayDetailedInformation.ViewModel) {
        typeValue.text = viewModel.types
        weightValue.text = viewModel.weight
        heightValue.text = viewModel.height
        pokemonImage.image = viewModel.sprites
    }
    
    
    private func setupUI() {
        
        view.addSubviews(bgView, pokemonImage, typeLabel, weightLabel, heightLabel, typeBg, weightBg, heightBg, typeValue, weightValue, heightValue)
        
        let offset: CGFloat = 50
        
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: view.topAnchor),
            bgView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bgView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            pokemonImage.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 170),
            pokemonImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokemonImage.heightAnchor.constraint(equalToConstant: 220),
            pokemonImage.widthAnchor.constraint(equalToConstant: 220),
            
            typeBg.topAnchor.constraint(equalTo: pokemonImage.bottomAnchor, constant: 70),
            typeBg.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -offset),
            typeValue.centerYAnchor.constraint(equalTo: typeBg.centerYAnchor),
            typeValue.centerXAnchor.constraint(equalTo: typeBg.centerXAnchor),
            typeLabel.centerYAnchor.constraint(equalTo: typeBg.centerYAnchor),
            typeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset),
            
            weightBg.topAnchor.constraint(equalTo: typeBg.bottomAnchor, constant: 40),
            weightBg.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -offset),
            weightValue.centerYAnchor.constraint(equalTo: weightBg.centerYAnchor),
            weightValue.centerXAnchor.constraint(equalTo: weightBg.centerXAnchor),
            weightLabel.centerYAnchor.constraint(equalTo: weightBg.centerYAnchor),
            weightLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset),
            
            heightBg.topAnchor.constraint(equalTo: weightBg.bottomAnchor, constant: 40),
            heightBg.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -offset),
            heightValue.centerYAnchor.constraint(equalTo: heightBg.centerYAnchor),
            heightValue.centerXAnchor.constraint(equalTo: heightBg.centerXAnchor),
            heightLabel.centerYAnchor.constraint(equalTo: heightBg.centerYAnchor),
            heightLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset),
            
        ])
    }
}


