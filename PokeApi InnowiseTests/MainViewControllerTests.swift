//
//  MainViewControllerTests.swift
//  PokeApi InnowiseTests
//
//  Created by Anna Zaitsava on 26.02.24.
//

import XCTest
@testable import PokeApi_Innowise

final class MainViewControllerTests: XCTestCase {
    
    var sut: MainViewController!
    var spyInteractor: MainInteractorSpy!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        spyInteractor = MainInteractorSpy()
        sut = MainViewController()
        sut.interactor = spyInteractor
    }
    
    override func tearDownWithError() throws {
        sut = nil
        spyInteractor = nil
        try super.tearDownWithError()
    }
    
    func testFetchPokemons() {
        let request = MainScreenDataFlow.Pokemons.Request()
        
        sut.interactor?.fetchPokemons(request: request)
        
        XCTAssertTrue(spyInteractor.fetchPokemonsCalled)
        XCTAssertNotNil(spyInteractor.request)
    }
    
    class MainInteractorSpy: MainLogic {
        var fetchPokemonsCalled = false
        var request: MainScreenDataFlow.Pokemons.Request?
        
        func fetchPokemons(request: MainScreenDataFlow.Pokemons.Request) {
            fetchPokemonsCalled = true
            self.request = request
        }
        
        func saveSelectedItem(pokemon: MainScreenDataFlow.Pokemons.ViewModel.PokemonList) {
        }
    }
}
