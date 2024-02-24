//
//  MainScreenCell.swift
//  PokeApi Innowise
//
//  Created by Anna Zaitsava on 18.02.24.
//

import UIKit

class MainScreenCell: UITableViewCell {
    
    static let identifier = "PokemonListCell"
    
    // MARK: View setup
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Pokemon"
        label.textColor = .black
        label.font = .bold20()
        return label
    }()
    
    private var bgView: UIView = {
        let view =  UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        view.layer.cornerRadius = 15
        return view
    }()
    
    // MARK: Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func configureCell(withName name: String) {
        nameLabel.text = name
    }
}

// MARK: Private methods

private extension MainScreenCell {
    func addSubviews() {
        contentView.addSubviews(bgView)
        bgView.addSubviews(nameLabel)
    }
    
    func makeConstraints() {
        let constant: CGFloat = 24
        
        NSLayoutConstraint.activate([
            bgView.heightAnchor.constraint(equalToConstant: 60),
            bgView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -constant),
            bgView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: constant),
            
            nameLabel.centerXAnchor.constraint(equalTo: bgView.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: bgView.centerYAnchor)
        ])
    }
}
