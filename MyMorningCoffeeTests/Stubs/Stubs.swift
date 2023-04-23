//
// My Morning Coffee
//
// Copyright © 2023 Roi Sagiv. All rights reserved.
// This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/
//

import OHHTTPStubs
import XCTest

///
class Stubs {
  ///
  class func setUp() {
    HTTPStubs.onStubMissing {
      if $0.url?.scheme == "file" {
        return
      }
      XCTFail("\($0.url?.absoluteString ?? "") was not stubbed")
    }
  }

  ///
  class func tearDown() {
    HTTPStubs.removeAllStubs()
  }

  class func searchByDate() {
    stub(condition: isHost("hn.algolia.com") && isPath("/api/v1/search_by_date")) { _ in

      HTTPStubsResponse(
        fileAtPath: OHPathForFile("search_by_date.json", Stubs.self)!,
        statusCode: 200,
        headers: ["Content-Type": "application/json; charset=utf-8"]
      )
    }
  }

  class func searchByDateNoInternetFailure() {
    stub(condition: isHost("hn.algolia.com") && isPath("/api/v1/search_by_date")) { _ in

      HTTPStubsResponse(
        error: NSError(domain: NSURLErrorDomain, code: URLError.notConnectedToInternet.rawValue)
      )
    }
  }
}
