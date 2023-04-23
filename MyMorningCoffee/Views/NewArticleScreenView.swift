//
// My Morning Coffee
//
// Copyright © 2023 Roi Sagiv. All rights reserved.
// This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/
//

import SwiftUI

///
struct NewArticleScreenView: View {
  let viewState: ArticlesViewModel.ViewState
  let now: Date

  ///
  var body: some View {
    ZStack {
      switch viewState {
      case .idle:
        ProgressView().scaleEffect(1.8)
      case .loading:
        ProgressView().scaleEffect(1.8)
      case let .success(articles):
        ArticleListView(articles: articles, now: now)
      case let .error(error):
        Text(error ?? "")
      }
    }
  }
}

///
struct NewArticleScreenView_Previews: PreviewProvider {
  ///
  static var previews: some View {
    Group {
      NewArticleScreenView(viewState: .idle, now: PreviewData.Dates.now)
        .previewDisplayName("idle")

      NewArticleScreenView(viewState: .loading, now: PreviewData.Dates.now)
        .previewDisplayName("loading")

      NewArticleScreenView(
        viewState: .success(articles: PreviewData.Articles.list),
        now: PreviewData.Dates.now
      )
      .previewDisplayName("success")

      NewArticleScreenView(
        viewState: .error(PreviewData.Articles.networkError.localizedDescription),
        now: PreviewData.Dates.now
      )
      .previewDisplayName("error")
    }
  }
}
