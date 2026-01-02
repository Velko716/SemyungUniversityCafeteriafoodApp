//
//  CafeteriaMenu.swift
//  Network
//
//  Created by 김진혁 on 1/1/26.
//

import Foundation

public struct CafeteriaMenu: Codable {
    public let breakfastMenu: String
    public let lunchMenu: String
    public let dinnerMenu: String

    public let breakfastLikeCount: Int
    public let lunchLikeCount: Int
    public let dinnerLikeCount: Int

    public let breakfastDislikeCount: Int
    public let lunchDislikeCount: Int
    public let dinnerDislikeCount: Int

    public init(
        breakfastMenu: String,
        lunchMenu: String,
        dinnerMenu: String,
        breakfastLikeCount: Int,
        lunchLikeCount: Int,
        dinnerLikeCount: Int,
        breakfastDislikeCount: Int,
        lunchDislikeCount: Int,
        dinnerDislikeCount: Int
    ) {
        self.breakfastMenu = breakfastMenu
        self.lunchMenu = lunchMenu
        self.dinnerMenu = dinnerMenu
        self.breakfastLikeCount = breakfastLikeCount
        self.lunchLikeCount = lunchLikeCount
        self.dinnerLikeCount = dinnerLikeCount
        self.breakfastDislikeCount = breakfastDislikeCount
        self.lunchDislikeCount = lunchDislikeCount
        self.dinnerDislikeCount = dinnerDislikeCount
    }

    enum CodingKeys: String, CodingKey {
        case breakfastMenu = "breakfast_menu"
        case lunchMenu = "lunch_menu"
        case dinnerMenu = "dinner_menu"
        
        case breakfastLikeCount = "breakfast_like_count"
        case lunchLikeCount = "lunch_like_count"
        case dinnerLikeCount = "dinner_like_count"
        
        case breakfastDislikeCount = "breakfast_dislike_count"
        case lunchDislikeCount = "lunch_dislike_count"
        case dinnerDislikeCount = "dinner_dislike_count"
    }
}
