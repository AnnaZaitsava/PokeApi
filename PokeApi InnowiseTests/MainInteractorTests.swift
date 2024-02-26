//
//  MainInteractorTests.swift
//  PokeApi InnowiseTests
//
//  Created by Anna Zaitsava on 25.02.24.
//

import XCTest
@testable import PokeApi_Innowise

final class MainInteractorTests: XCTestCase {
    
    var sut: MainInteractor!
    var spyPresenter: MainPresentationLogicSpy!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = MainInteractor()
        spyPresenter = MainPresentationLogicSpy()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        spyPresenter = nil
        try super.tearDownWithError()
    }
    
    func testFetchPokemonsSuccess() throws {
        sut.presenter = spyPresenter
        let request = MainScreenDataFlow.Pokemons.Request()
        sut.fetchPokemons(request: request)
        
        let expectation = expectation(description: "Fetch pokemons")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertTrue(self.spyPresenter.presentFetchedPokemonsCalled, "fetchPokemons should call the presenter presentFetchedPokemons")
            XCTAssertEqual(self.spyPresenter.presentFetchedPokemonsResponse?.pokemons.first?.name, "bulbasaur")
            XCTAssertEqual(self.spyPresenter.presentFetchedPokemonsResponse?.pokemons.first?.url, "https://pokeapi.co/api/v2/pokemon/1/")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    class  MainPresentationLogicSpy: MainPresentationLogic {
        var presentFetchedPokemonsCalled =  false
        var presentAlertCalled =  false
        var presentFetchedPokemonsResponse: MainScreenDataFlow.Pokemons.Response?
        
        func presentFetchedPokemons(response: MainScreenDataFlow.Pokemons.Response) {
            presentFetchedPokemonsCalled =  true
            presentFetchedPokemonsResponse =  response
        }
        
        func presentAlert(with title: String, and messsage: String) {
            presentAlertCalled =  true
        }
    }
}
