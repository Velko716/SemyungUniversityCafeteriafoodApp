//
//  MealCountType.swift
//  Domain
//
//  Created by 김진혁 on 1/24/26.
//

import Foundation

public enum MealTimeType: String {
    case breakfast
    case lunch
    case dinner
}

public enum CountActionType: String {
    case like
    case dislike
}

public extension MealTimeType {
    func fieldKey(for action: CountActionType) -> String {
        "\(self.rawValue)_\(action.rawValue)_count"
    }
}
