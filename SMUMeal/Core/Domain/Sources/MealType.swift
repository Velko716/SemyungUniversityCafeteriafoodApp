//
//  MealType.swift
//  Domain
//
//  Created by 김진혁 on 2/12/26.
//

import Foundation

public enum MealType: String, Codable {
    case breakfast
    case lunch
    case dinner

    /// 현재 시간대에 해당하는 식사 타입 반환
    /// - ~09:20 아침, 09:21~14:30 점심, 14:31~18:50 저녁, 18:51~ nil
    public static func current() -> MealType? {
        let calendar = Calendar.current
        let now = Date()
        let hour = calendar.component(.hour, from: now)
        let minute = calendar.component(.minute, from: now)
        let totalMinutes = hour * 60 + minute

        switch totalMinutes {
        case ...560:       // ~ 09:20
            return .breakfast
        case 561...870:    // 09:21 ~ 14:30
            return .lunch
        case 871...1130:   // 14:31 ~ 18:50
            return .dinner
        default:           // 18:51 ~
            return nil
        }
    }
}
