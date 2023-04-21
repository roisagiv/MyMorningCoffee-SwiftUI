//
// My Morning Coffee
//
// Copyright © 2023 Roi Sagiv. All rights reserved.
// This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/
//

import Foundation

struct Dates {
  private static var iso8601formatter: ISO8601DateFormatter {
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds, .withFullDate]
    return formatter
  }

  private static var relativeFormatter: RelativeDateTimeFormatter {
    let formatter = RelativeDateTimeFormatter()
    formatter.unitsStyle = .full
    return formatter
  }

  public static func date(from: String) -> Date? {
    iso8601formatter.date(from: from)
  }

  public static func relativeTime(for: String, now: Date) -> String {
    guard let date = date(from: `for`) else {
      return ""
    }
    return relativeFormatter.localizedString(for: date, relativeTo: now)
  }
}
