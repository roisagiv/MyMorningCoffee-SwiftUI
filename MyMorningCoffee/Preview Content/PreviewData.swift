//
// My Morning Coffee
//
// Copyright © 2023 Roi Sagiv. All rights reserved.
// This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/
//

import Foundation

struct PreviewData {
  enum Articles {
    static var tikTok: Article = .init(
      id: 1,
      title: "TikTok tics: when Tourette’s syndrome went viral",
      coverImageUrl: "https://fakeimg.pl/350x200/?text=churchil",
      author: "churchill",
      createdAt: "2023-04-20T19:38:33.000Z",
      url: "https://bigthink.com/health/social-media-mass-hysteria/",
      category: "Story"
    )

    static var list: [Article] = [
      tikTok,
      .init(
        id: 2,
        title: "GitHub Copilot emits GPL code",
        coverImageUrl: "https://fakeimg.pl/350x200",
        author: "fortenforge",
        createdAt: "2023-04-20T19:38:33.000Z",
        url: "https://codeium.com/blog/copilot-trains-on-gpl-codeium-does-not",
        category: "Story"
      ),
      .init(
        id: 3,
        title: "Faster LZ is not the answer to 150-250 GB video game downloads",
        coverImageUrl: "https://fakeimg.pl/350x200",
        author: "ingve",
        createdAt: "2023-04-20T19:38:33.000Z",
        url: "http://richg42.blogspot.com/2023/04/faster-lz-is-not-answer-to-150-250-gb.html",
        category: "Story"
      )
    ]
  }
}
