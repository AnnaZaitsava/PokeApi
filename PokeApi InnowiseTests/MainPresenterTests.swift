//
//  MainPresenterTests.swift
//  PokeApi InnowiseTests
//
//  Created by Anna Zaitsava on 26.02.24.
//

import XCTest
@testable import PokeApi_Innowise

final class MainPresenterTests: XCTestCase {
    
    var sut: MainPresenter!
    var spyViewController: MainDisplayLogicSpy!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = MainPresenter()
        spyViewController = MainDisplayLogicSpy()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        spyViewController = nil
        try super.tearDownWithError()
    }
    
    func testFetchPokemonsSuccess() throws {
        sut.viewController = spyViewController
        let pokemons = [Pokemon(url: "url1", name: "name1"),
                        Pokemon(url: "url2", name: "name2")]
        
        let response = MainScreenDataFlow.Pokemons.Response(next: "", pokemons: pokemons)
        sut.presentFetchedPokemons(response: response)
        
        XCTAssertTrue(spyViewController.displayPokemonListCalled,
                      "presentFetchedPokemons should display Pokemons in the viewController")
        XCTAssertEqual(spyViewController.displayPokemonListViewModel?.pokemonListViewModel.count, 2)
        XCTAssertEqual(spyViewController.displayPokemonListViewModel?.pokemonListViewModel[0].name,
                       "Name1", "presentFetchedPokemons should change name to correct format")
        XCTAssertEqual(spyViewController.displayPokemonListViewModel?.pokemonListViewModel[1].name,
                       "Name2", "presentFetchedPokemons should change name to correct format" )
    }
    
    class  MainDisplayLogicSpy: MainDisplayLogic {
        var displayPokemonListCalled = false
        var displayPokemonListViewModel: MainScreenDataFlow.Pokemons.ViewModel?
        
        var displayAlertCalled = false
        var displayedAlertTitle: String?
        var displayedAlertMessage: String?
        
        func displayPokemonList(viewModel: MainScreenDataFlow.Pokemons.ViewModel) {
            displayPokemonListCalled = true
            displayPokemonListViewModel = viewModel
        }
        
        func displayAlert(with title: String, and message: String) {
            displayAlertCalled = true
            displayedAlertTitle = title
            displayedAlertMessage = message
        }
    }
}
