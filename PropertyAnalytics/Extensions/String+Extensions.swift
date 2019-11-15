//
//  String+Extensions.swift
//  PropertyAnalytics
//
//  Created by Yanik Simpson on 11/14/19.
//  Copyright © 2019 Yanik Simpson. All rights reserved.
//

import Foundation

extension String {
    func getDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: self)
    }
}
