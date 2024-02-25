//
//  PokeApi_InnowiseTests.swift
//  PokeApi InnowiseTests
//
//  Created by Anna Zaitsava on 21.02.24.
//

import XCTest
@testable import PokeApi_Innowise

final class PokeApi_InnowiseTests: XCTestCase {
    
    var sut: Network!
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = Network()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testExample() throws {
        let url = "https://pokeapi.co/api/v2/pokemon/1"
        let expectation = expectation(description: "Fetch pokemon details")
        sut.fetchPokemonDetails(from: url) { result in
            switch result {
            case .success(let details):
                XCTAssertEqual(details.id, 1)
                XCTAssertEqual(details.name, "bulbasaur")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
