//
// My Morning Coffee
//
// Copyright © 2023 Roi Sagiv. All rights reserved.
// This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/
//

@testable import MyMorningCoffee
import XCTest

final class DatesTests: XCTestCase {
  ///
  func testFullISO8601Parsing() throws {
    let date = "2023-04-22T19:38:33.000Z"
    guard let result = Dates.date(from: date) else {
      XCTFail("result is nil")
      return
    }
    var calendar = Calendar.current
    calendar.timeZone = .gmt
    let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: result)
    XCTAssertEqual(components.year, 2023)
    XCTAssertEqual(components.month, 4)
    XCTAssertEqual(components.day, 22)
    XCTAssertEqual(components.hour, 19)
    XCTAssertEqual(components.minute, 38)
    XCTAssertEqual(components.second, 33)
  }

  ///
  func testDateSince() throws {
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    guard let now = formatter.date(from: "2023-04-23T19:38:33.000Z") else {
      XCTFail()
      return
    }

    let date = "2023-04-22T19:38:33.000Z"
    let result = Dates.relativeTime(for: date, now: now)
    XCTAssertEqual(result, "1 day ago")
  }
}
