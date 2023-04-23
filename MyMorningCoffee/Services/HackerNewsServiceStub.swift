//
// My Morning Coffee
//
// Copyright © 2023 Roi Sagiv. All rights reserved.
// This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/
//

import Foundation

///
struct HackerNewsServiceStub: HackerNewsService {
  init(stories: [HackerNewsStory]) {
    self.stories = stories
  }

  init(articles: [Article]) {
    stories = articles.map {
      HackerNewsStory(
        id: $0.id, time: $0.createdAt, title: $0.title ?? "", url: $0.url, type: "Story", author: $0.author
      )
    }
  }

  let stories: [HackerNewsStory]

  ///
  func lastStories() async throws -> [HackerNewsStory] {
    try await Task.sleep(nanoseconds: NSEC_PER_MSEC * 30)
    return stories
  }
}
