//
// My Morning Coffee
//
// Copyright © 2023 Roi Sagiv. All rights reserved.
// This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/
//

import SwiftUI

///
@MainActor
class ArticlesViewModel: ObservableObject {
  ///
  @Published var viewState: ViewState = .idle

  ///
  private let hackerNewsService: HackerNewsService

  ///
  init(hackerNewsService: HackerNewsService) {
    self.hackerNewsService = hackerNewsService
  }

  ///
  public func loadArticles() async {
    // loading state
    viewState = .loading

    do {
      let stories = try await hackerNewsService.lastStories()

      // success state
      viewState = .success(articles:
        stories.map {
          Article(
            id: $0.id,
            title: $0.title,
            coverImageUrl: nil,
            author: $0.author,
            createdAt: $0.time,
            url: $0.url ?? "",
            category: "Story"
          )
        }
      )

    } catch {
      // error state
      viewState = .error(error.localizedDescription)
    }
  }
}

///
extension ArticlesViewModel {
  ///
  enum ViewState: Equatable {
    case idle
    case loading
    case success(articles: [Article])
    case error(_ error: String?)

    var rawValue: String {
      switch self {
      case .idle: return "idle"
      case .loading: return "loading"
      case .success: return "success"
      case .error: return "error"
      }
    }
  }
}
