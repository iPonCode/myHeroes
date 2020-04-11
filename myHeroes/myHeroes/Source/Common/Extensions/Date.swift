//  Date.swift
//  myHeroes
//
//  Created by Simón Aparicio on 01/04/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import Foundation

extension Date {

    static func dateFormatted(dateString: String) -> Date? {
        return Date.iso8601Formatter.date(from: dateString)
    }

    private static let iso8601Formatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate,
                .withTime,
                .withDashSeparatorInDate,
                .withColonSeparatorInTime]
        return formatter
    }()

}
