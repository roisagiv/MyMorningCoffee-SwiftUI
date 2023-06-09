//
// My Morning Coffee
//
// Copyright © 2023 Roi Sagiv. All rights reserved.
// This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/
//

import SwiftUI

@main
struct MyMorningCoffeeApp: App {
  var body: some Scene {
    let viewModel = ArticlesViewModel(hackerNewsService: HackerNewsAlgoliaService())
    WindowGroup {
      ArticlesContainerView(viewModel: viewModel, now: Date())
    }
  }
}
