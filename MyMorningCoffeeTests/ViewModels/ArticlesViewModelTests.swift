//
// My Morning Coffee
//
// Copyright © 2023 Roi Sagiv. All rights reserved.
// This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/
//

@testable import MyMorningCoffee
import XCTest

///
@MainActor
final class ArticlesViewModelTests: XCTestCase {
  override func setUpWithError() throws {
    Stubs.setUp()
  }

  override func tearDownWithError() throws {
    Stubs.tearDown()
  }

  ///
  func testInitialData() throws {
    let hackerNewsService = HackerNewsAlgoliaService()
    let viewModel = ArticlesViewModel(hackerNewsService: hackerNewsService)
    XCTAssertEqual(viewModel.viewState, .idle)
  }

  ///
  func testLoadArticlesSucceed() async throws {
    Stubs.searchByDate()
    let hackerNewsService = TestableHackerNewsService(algolia: HackerNewsAlgoliaService())
    let viewModel = ArticlesViewModel(hackerNewsService: hackerNewsService)

    let expectation = XCTestExpectation(description: "state changes")
    expectation.expectedFulfillmentCount = 2

    var values: [ArticlesViewModel.ViewState] = []
    let cancellable = viewModel.$viewState.dropFirst().sink { value in
      values.append(value)
      expectation.fulfill()
    }

    await viewModel.loadArticles()
    await fulfillment(of: [expectation], timeout: 1)

    XCTAssertEqual(values[0], .loading)
    let articles = hackerNewsService.stories.map {
      Article(
        id: $0.id,
        title: $0.time,
        coverImageUrl: nil,
        author: $0.author,
        createdAt: $0.time,
        url: $0.url ?? "",
        category: "Story"
      )
    }
    XCTAssertEqual(values[1], .success(articles: articles))

    cancellable.cancel()
  }

  ///
  func testLoadArticlesFails() async throws {
    Stubs.searchByDateNoInternetFailure()
    let hackerNewsService = HackerNewsAlgoliaService()
    let viewModel = ArticlesViewModel(hackerNewsService: hackerNewsService)

    let expectation = XCTestExpectation(description: "state changes")
    expectation.expectedFulfillmentCount = 2

    var values: [ArticlesViewModel.ViewState] = []
    let cancellable = viewModel.$viewState.dropFirst().sink { value in
      values.append(value)
      expectation.fulfill()
    }

    await viewModel.loadArticles()
    await fulfillment(of: [expectation], timeout: 1)

    XCTAssertEqual(values[0], .loading)
    XCTAssertEqual(values[1], .error("URLSessionTask failed with error: The operation couldn’t be completed. (NSURLErrorDomain error -1009.)"))

    cancellable.cancel()
  }
}

class TestableHackerNewsService: HackerNewsService {
  let algolia: HackerNewsAlgoliaService
  var stories: [HackerNewsStory]

  init(algolia: HackerNewsAlgoliaService, stories: [HackerNewsStory] = []) {
    self.algolia = algolia
    self.stories = stories
  }

  func lastStories() async throws -> [MyMorningCoffee.HackerNewsStory] {
    stories = try await algolia.lastStories()
    return stories
  }
}
