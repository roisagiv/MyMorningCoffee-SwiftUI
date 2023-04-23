//
// My Morning Coffee
//
// Copyright © 2023 Roi Sagiv. All rights reserved.
// This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/
//

@testable import MyMorningCoffee
import XCTest

final class HackerNewsAlgoliaServiceTests: XCTestCase {
  override func setUpWithError() throws {
    Stubs.setUp()
  }

  override func tearDownWithError() throws {
    Stubs.tearDown()
  }

  ///
  func testSearchByDateSucceed() async throws {
    Stubs.searchByDate()

    let service: HackerNewsService = HackerNewsAlgoliaService()

    let stories = try await service.lastStories()

    XCTAssertEqual(stories.count, 20)
  }

  ///
  func testSearchByDateWithNoInternetFails() async throws {
    Stubs.searchByDateNoInternetFailure()

    let service: HackerNewsService = HackerNewsAlgoliaService()

    do {
      _ = try await service.lastStories()
      XCTFail("expect to throw an error")
    } catch {
      XCTAssertNotNil(error)
    }
  }
}
