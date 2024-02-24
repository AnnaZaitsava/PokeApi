//
//  DetailsScreenViewController.swift
//  PokeApi Innowise
//
//  Created by Anna Zaitsava on 17.02.24.

import UIKit
import Lottie

protocol DetailsDisplayLogic: AnyObject {
    func displayData(viewModel: DetailsScreenDataFlow.Info.ViewModel)
    func displayAlert(with title: String, and message: String)
}

final class DetailsScreenViewController: UIViewController {
    
    // MARK: variables
    
    var interactor: DetailedBusinessLogic?
    var router: (NSObjectProtocol & DetailedRoutingLogic & DetailedDataPassing)?
    
    private var isLoading = false {
        didSet {
            handleLoading()
        }
    }
    
    private var bgView = UIImageView(image: UIImage(named: "bg"))
    private var pokemonImage = UIImageView()
    
    private var nameLabel = UILabel(text: "Name", font: .bold32(), textColor: .black)
    private var typeLabel = UILabel(text: "Type", textColor: .black)
    private var weightLabel = UILabel(text: "Weight", textColor: .black)
    private var heightLabel = UILabel(text: "Height", textColor: .black)
    
    private var typeBg = UIView.makeBgView(bgColor: .white)
    private var weightBg = UIView.makeBgView(bgColor: .white)
    private var heightBg = UIView.makeBgView(bgColor: .white)
    
    private var typeValue = UILabel(text: "Type",
                                         font: .medium18(),
                                         textColor: .black)
    private var weightValue = UILabel(text: "Weight",
                                           font: .medium18(),
                                           textColor: .black)
    private var heightValue = UILabel(text: "Height",
                                           font: .medium18(),
                                           textColor: .black)
    
    private let loaderView: LottieAnimationView = {
        let view = LottieAnimationView(name: "loading-circle-animation")
        view.animationSpeed = 1
        view.loopMode = .loop
        view.tintColor = .blue
        view.contentMode = .center
        return view
    }()
    
    // MARK: Initialization
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        build()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        build()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        makeConstraints()
        showDetailedCharacterInformation()
        self.navigationItem.title = ""
    }
    
    func showDetailedCharacterInformation() {
        isLoading = true
        interactor?.fetchDetailedInformation()
    }
}

extension DetailsScreenViewController: DetailsDisplayLogic {
    func displayData(viewModel: DetailsScreenDataFlow.Info.ViewModel) {
        isLoading = false
        nameLabel.text = viewModel.name
        typeValue.text = viewModel.types
        weightValue.text = viewModel.weight
        heightValue.text = viewModel.height
        pokemonImage.image = viewModel.sprites
    }
    
    func displayAlert(with title: String, and message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
        }
}

private extension DetailsScreenViewController {
    // MARK: Setup
    
    func build() {
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
    
    func handleLoading() {
        loaderView.isHidden = isLoading ? false : true
        isLoading ? loaderView.play() : loaderView.stop()
        updateView(isLoading)
    }
    
    func updateView(_ isLoading: Bool) {
        [pokemonImage, nameLabel, typeLabel, weightLabel, heightLabel,
         typeBg, weightBg, heightBg, typeValue, weightValue, heightValue].forEach { $0.isHidden = isLoading }
    }
    
    func addSubviews() {
        view.addSubviews(
            bgView,
            pokemonImage,
            nameLabel,
            typeLabel,
            weightLabel,
            heightLabel,
            typeBg,
            weightBg,
            heightBg,
            typeValue,
            weightValue,
            heightValue,
            loaderView
        )
    }
    
    func makeConstraints() {
        
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: view.topAnchor),
            bgView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bgView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            pokemonImage.topAnchor.constraint(equalTo: bgView.topAnchor,
                                              constant: Constants.pokemonImageTopMargin),
            pokemonImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokemonImage.heightAnchor.constraint(equalToConstant: Constants.pokemonImageSize),
            pokemonImage.widthAnchor.constraint(equalToConstant: Constants.pokemonImageSize),
            
            nameLabel.topAnchor.constraint(equalTo: pokemonImage.bottomAnchor,
                                           constant: Constants.nameLabelTopMargin),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            typeBg.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,
                                        constant: Constants.infoLabelsTopMargin),
            typeBg.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                             constant: -Constants.sideMargin),
            typeValue.centerYAnchor.constraint(equalTo: typeBg.centerYAnchor),
            typeValue.centerXAnchor.constraint(equalTo: typeBg.centerXAnchor),
            typeLabel.centerYAnchor.constraint(equalTo: typeBg.centerYAnchor),
            typeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                               constant: Constants.sideMargin),
            
            weightBg.topAnchor.constraint(equalTo: typeBg.bottomAnchor,
                                          constant: Constants.spacingBetweenInfoLabels),
            weightBg.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                               constant: -Constants.sideMargin),
            weightValue.centerYAnchor.constraint(equalTo: weightBg.centerYAnchor),
            weightValue.centerXAnchor.constraint(equalTo: weightBg.centerXAnchor),
            weightLabel.centerYAnchor.constraint(equalTo: weightBg.centerYAnchor),
            weightLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                 constant: Constants.sideMargin),
            
            heightBg.topAnchor.constraint(equalTo: weightBg.bottomAnchor,
                                          constant: Constants.spacingBetweenInfoLabels),
            heightBg.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                               constant: -Constants.sideMargin),
            heightValue.centerYAnchor.constraint(equalTo: heightBg.centerYAnchor),
            heightValue.centerXAnchor.constraint(equalTo: heightBg.centerXAnchor),
            heightLabel.centerYAnchor.constraint(equalTo: heightBg.centerYAnchor),
            heightLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                 constant: Constants.sideMargin),
            
            loaderView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
