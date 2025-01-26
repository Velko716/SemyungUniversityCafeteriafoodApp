//
//  DateExtension.swift
//  WebCrawlingProject
//
//  Created by 김진혁 on 1/24/25.
//


import Foundation

extension Date {
    func settingTime(hour: Int, minute: Int, timeZone: TimeZone) -> Date? {
        var calendar = Calendar.current
        calendar.timeZone = timeZone
        var components = calendar.dateComponents([.year, .month, .day], from: self)
        components.hour = hour
        components.minute = minute
        return calendar.date(from: components)
    }
}

