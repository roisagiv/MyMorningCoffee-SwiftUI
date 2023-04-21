//
// My Morning Coffee
//
// Copyright © 2023 Roi Sagiv. All rights reserved.
// This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/
//

import Foundation

struct Article: Codable, Hashable, Identifiable {
  let id: Int
  let title: String?
  let coverImageUrl: String?
  let author: String?
  let createdAt: String?
  let url: String
  let category: String
}
