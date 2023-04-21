//
// My Morning Coffee
//
// Copyright © 2023 Roi Sagiv. All rights reserved.
// This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/
//

import SwiftUI

struct ArticleListView: View {
  internal let articles: [Article]
  internal let now: Date

  var body: some View {
    List {
      ForEach(articles) { article in
        ArticleListItemView(article: article, now: now)
//          .listRowInsets(.init())
          .listRowSeparator(.hidden)
      }
    }
    .listStyle(.plain)
  }
}

struct ArticleListView_Previews: PreviewProvider {
  static var previews: some View {
    let now = Dates.date(from: "2023-04-23T19:38:33.000Z") ?? Date.now
    return ArticleListView(articles: PreviewData.Articles.list, now: now)
  }
}
