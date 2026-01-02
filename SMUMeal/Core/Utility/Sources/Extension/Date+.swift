//
//  Date+.swift
//  Utility
//
//  Created by 김진혁 on 1/1/26.
//

import Foundation

extension Date {
    /// Firebase 저장용 포맷 (2025-01-02)
    public var fullDateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: self)
    }

    /// 화면 표시용 포맷 (1월 2일 (목))
    public var displayString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "M월 d일 (E)"
        return formatter.string(from: self)
    }

    /// 날짜 더하기
    public func adding(days: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: days, to: self) ?? self
    }

    /// 오늘인지 확인
    public var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }
}
