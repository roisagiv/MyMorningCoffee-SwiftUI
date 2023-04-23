//
// My Morning Coffee
//
// Copyright © 2023 Roi Sagiv. All rights reserved.
// This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/
//

import Foundation

protocol HackerNewsService {
  func lastStories() async throws -> [HackerNewsStory]
}

struct HackerNewsStory {
  let id: Int
  let time: String?
  let title: String
  let url: String?
  let type: String
  let author: String?
}
