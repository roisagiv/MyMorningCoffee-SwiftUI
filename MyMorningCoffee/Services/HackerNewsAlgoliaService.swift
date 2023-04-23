//
// My Morning Coffee
//
// Copyright © 2023 Roi Sagiv. All rights reserved.
// This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/
//

import Alamofire

///
struct HackerNewsAlgoliaService: HackerNewsService {
  ///
  private let baseURL = "https://hn.algolia.com"

  ///
  func lastStories() async throws -> [HackerNewsStory] {
    let result = try await AF
      .request("\(baseURL)/api/v1/search_by_date?tags=story&hitsPerPage=1000")
      .serializingDecodable(SearchByDateResult.self)
      .value

    return result.hits.map {
      HackerNewsStory(
        id: Int($0.objectID) ?? 0,
        time: $0.createdAt,
        title: $0.title,
        url: $0.url,
        type: "Story",
        author: $0.author
      )
    }
  }

  ///
  struct Story: Codable {
    let createdAt: String
    let title: String
    let url: String?
    let author: String
    let objectID: String

    enum CodingKeys: String, CodingKey {
      case createdAt = "created_at"
      case title
      case url
      case author
      case objectID
    }
  }

  ///
  struct SearchByDateResult: Codable {
    let hits: [Story]

    enum CodingKeys: String, CodingKey {
      case hits
    }
  }
}
