//
//  Holiday.swift
//  Domain
//
//  Created by 김진혁 on 2/15/26.
//

import Foundation

public struct Holiday: Equatable, Hashable {
    public let date: Date
    public let name: String
    public let isHoliday: Bool  // 공공기관 휴일여부 (Y/N)

    public init(date: Date, name: String, isHoliday: Bool) {
        self.date = date
        self.name = name
        self.isHoliday = isHoliday
    }
}
