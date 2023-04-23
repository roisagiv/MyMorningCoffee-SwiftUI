//
// My Morning Coffee
//
// Copyright © 2023 Roi Sagiv. All rights reserved.
// This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/
//

import SwiftUI

///
struct ArticlesContainerView: View {
  @StateObject var viewModel: ArticlesViewModel
  let now: Date

  ///
  var body: some View {
    NewArticleScreenView(viewState: viewModel.viewState, now: now)
      .task {
        await viewModel.loadArticles()
      }
  }
}

///
struct ArticlesContainerView_Previews: PreviewProvider {
  static var previews: some View {
    let now = Dates.date(from: "2023-04-23T19:38:33.000Z") ?? Date.now
    let articles = PreviewData.Articles.list
    let service = HackerNewsServiceStub(articles: articles)
    let viewModel = ArticlesViewModel(hackerNewsService: service)

    return ArticlesContainerView(viewModel: viewModel, now: now)
  }
}
