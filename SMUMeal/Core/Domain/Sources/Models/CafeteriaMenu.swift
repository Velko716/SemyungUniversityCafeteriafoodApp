//
//  CafeteriaMenu.swift
//  Domain
//
//  Created by 김진혁 on 1/1/26.
//

import Foundation

public struct Reaction: Decodable {
    public let likeCount: Int
    public let dislikeCount: Int

    enum CodingKeys: String, CodingKey {
        case likeCount = "like_count"
        case dislikeCount = "dislike_count"
    }

    public init(likeCount: Int = 0, dislikeCount: Int = 0) {
        self.likeCount = likeCount
        self.dislikeCount = dislikeCount
    }
}

public struct CafeteriaMenu: Decodable {
    public var breakfastMenu: String
    public var lunchMenu: String
    public var dinnerMenu: String
    public let reactions: [String: Reaction]

    enum CodingKeys: String, CodingKey {
        case breakfastMenu = "breakfast_menu"
        case lunchMenu = "lunch_menu"
        case dinnerMenu = "dinner_menu"
        case reactions
    }

    public init(
        breakfastMenu: String,
        lunchMenu: String,
        dinnerMenu: String,
        reactions: [String: Reaction] = [:]
    ) {
        self.breakfastMenu = breakfastMenu
        self.lunchMenu = lunchMenu
        self.dinnerMenu = dinnerMenu
        self.reactions = reactions
    }

    public func reaction(for mealType: MealType) -> Reaction {
        reactions[mealType.rawValue] ?? Reaction()
    }
}
