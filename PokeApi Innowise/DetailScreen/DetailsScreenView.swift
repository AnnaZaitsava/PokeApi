//
//  DetailsScreenView.swift
//  PokeApi Innowise
//
//  Created by Anna Zaitsava on 18.02.24.
//

import UIKit

class DetailsScreenView: UIView {
    
    //MARK: - Elements
    
    private lazy var  bgView: UIImageView = {
     let view = UIImageView()
        view.image = UIImage(named: "bg")
        return view
    }()
    
    private lazy var pokemonImage: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var typeLabel = UILabel(text: "Type", textColor: .black)
    private lazy var weightLabel = UILabel(text: "Weight", textColor: .black)
    private lazy var heightLabel = UILabel(text: "Height", textColor: .black)
    
    private lazy var typeBg = UIView.createLabelView(withText: "1")
    private lazy var weightBg = UIView.createLabelView(withText: "2")
    private lazy var heightBg = UIView.createLabelView(withText: "3")
    
    
     //MARK: - Initializer
     override init(frame: CGRect) {
         super.init(frame: frame)
         setupSubviews()
         setupConstraints()
     }
     
     required init?(coder: NSCoder) {
         super.init(coder: coder)
         setupSubviews()
         setupConstraints()
     }
    
    //MARK: - Setup UI
    
    private func setupSubviews() {
        addSubviews(bgView, pokemonImage, typeLabel, weightLabel, heightLabel, typeBg, weightBg, heightBg)
    }
    
    private func setupConstraints() {
        
        let offset: CGFloat = 50
        
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: topAnchor),
            bgView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bgView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            pokemonImage.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 170),
            pokemonImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            typeBg.topAnchor.constraint(equalTo: pokemonImage.bottomAnchor, constant: 70),
            typeBg.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -offset),
            typeLabel.centerYAnchor.constraint(equalTo: typeBg.centerYAnchor),
            typeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: offset),
            
            weightBg.topAnchor.constraint(equalTo: typeBg.bottomAnchor, constant: 40),
            weightBg.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -offset),
            weightLabel.centerYAnchor.constraint(equalTo: weightBg.centerYAnchor),
            weightLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: offset),
            
            heightBg.topAnchor.constraint(equalTo: weightBg.bottomAnchor, constant: 40),
            heightBg.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -offset),
            heightLabel.centerYAnchor.constraint(equalTo: weightBg.centerYAnchor),
            heightLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: offset),
                       
        ])
    }
}
