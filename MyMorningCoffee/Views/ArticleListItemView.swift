//
// My Morning Coffee
//
// Copyright © 2023 Roi Sagiv. All rights reserved.
// This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/
//

import SwiftUI

struct ArticleListItemView: View {
  internal let article: Article
  internal let now: Date

  private let imageHeight = 88.0

  var body: some View {
    HStack(alignment: .center) {
      AsyncImage(url: URL(string: article.url))
        .frame(width: imageHeight, height: imageHeight)
        .clipShape(RoundedRectangle(cornerRadius: 12))

      VStack(alignment: .leading, spacing: 1) {
        Text(article.category)
          .font(.caption)

        Text(article.title ?? "")
          .lineLimit(2)
          .font(.body)
          .fontWeight(.semibold)
//          .frame(maxHeight: .infinity, alignment: .center)

        HStack(alignment: .center) {
          Text(article.author ?? "")
            .font(.subheadline)
            .lineLimit(1)
          Text("·")
            .fontWeight(.heavy)
          Text(Dates.relativeTime(for: article.createdAt ?? "", now: now))
            .font(.subheadline)
            .lineLimit(1)
          Spacer()
        } // HStack
      } // VStack
      .padding(2)
//      .frame(maxHeight: .infinity)
    } // HStack
    .frame(height: imageHeight)
  }
}

struct ArticleListItemView_Previews: PreviewProvider {
  static var previews: some View {
    let now = Dates.date(from: "2023-04-23T19:38:33.000Z") ?? Date.now
    return Group {
      ArticleListItemView(article: PreviewData.Articles.tikTok, now: now)
      ArticleListItemView(article: PreviewData.Articles.loremIpsum, now: now)
    }
    .previewLayout(.sizeThatFits)
    .padding()
  }
}
