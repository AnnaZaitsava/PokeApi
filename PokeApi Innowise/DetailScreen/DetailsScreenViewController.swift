//
//  DetailsScreenViewController.swift
//  PokeApi Innowise
//
//  Created by Anna Zaitsava on 17.02.24.


import UIKit


class DetailsScreenViewController: UIViewController {
    
    private let detailsView = DetailsScreenView()
    
    override func viewDidLoad() {
           super.viewDidLoad()
        view.backgroundColor = .white
       }
    
    private func setupUI() {
            view.addSubviews(detailsView)
            
            NSLayoutConstraint.activate([
                detailsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                detailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                detailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                detailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
            
        }
}


