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

  func testParsePokemonModel() {
    let mainContainer = PKMNMainContainer()

    mainContainer.getMockedPokemonUseCase.execute { result in
      guard case .success = result else {
        XCTAssertTrue(false)
        return
      }
      XCTAssertTrue(true)
    }
  }

  func testParsePokemonsListModel() {
    let mainContainer = PKMNMainContainer()

    mainContainer.getMockedPokemonsListUseCase.execute { result in
      guard case .success = result else {
        XCTAssertTrue(false)
        return
      }
      XCTAssertTrue(true)
    }
  }
}
