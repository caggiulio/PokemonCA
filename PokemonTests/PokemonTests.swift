//
//  PokemonTests.swift
//  PokemonTests
//
//  Created on 24/01/22.
//

import XCTest
@testable import PokemonTest

class PokemonTests: XCTestCase {
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testParsePokemonModel() async throws {
    let manager = DependencyManager()
    @Injected var getMockedPokemonUseCase: PKMNUseCases.GetMockedPokemon

    do {
      let _ = try await getMockedPokemonUseCase.execute()
      XCTAssertTrue(true)
    } catch {
      XCTAssertTrue(false)
    }
  }

  func testParsePokemonsListModel() async throws {
    let manager = DependencyManager()
    @Injected var getMockedPokemonsListUseCase: PKMNUseCases.GetMockedPokemonsList

    do {
      let _ = try await getMockedPokemonsListUseCase.execute()
      XCTAssertTrue(true)
    } catch {
      XCTAssertTrue(false)
    }
  }
}
