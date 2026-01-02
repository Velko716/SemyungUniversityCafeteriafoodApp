//
//  CarouselView.swift
//  Components
//
//  Created by 김진혁 on 1/2/26.
//

import SwiftUI

// MARK: - MealCardView (단일 카드)

public struct MealCardView: View {
    public let dateString: String
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
        dateString: String,
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
        self.dateString = dateString
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
    
    public var body: some View {
        VStack(spacing: 12) {
            Text(dateString)
            // 날짜 헤더
            HStack {
                Text(breakfastMenu)
                Text(lunchMenu)
                Text(dinnerMenu)
                Text("\(breakfastLikeCount)")
                Text("\(lunchLikeCount)")
                Text("\(dinnerLikeCount)")
                Text("\(breakfastDislikeCount)")
                Text("\(lunchDislikeCount)")
                Text("\(dinnerDislikeCount)")
            }
        }
    }
}

// MARK: - CarouselView (스크롤 캐러셀)
public struct CarouselView: View {
    public let dateString: String
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
        dateString: String,
        breakfastMenu: String,
        lunchMenu: String,
        dinnerMenu: String,
        breakfastLikeCount: Int,
        lunchLikeCount: Int,
        dinnerLikeCount: Int,
        breakfastDislikeCount: Int,
        lunchDislikeCount: Int,
        dinnerDislikeCount: Int,
    ) {
        self.dateString = dateString
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
    
    public var body: some View {
        MealCardView(
            dateString: dateString,
            breakfastMenu: breakfastMenu,
            lunchMenu: lunchMenu,
            dinnerMenu: dinnerMenu,
            breakfastLikeCount: breakfastLikeCount,
            lunchLikeCount: lunchLikeCount,
            dinnerLikeCount: dinnerLikeCount,
            breakfastDislikeCount: breakfastDislikeCount,
            lunchDislikeCount: lunchDislikeCount,
            dinnerDislikeCount: dinnerDislikeCount
        )
    }
}

// MARK: - Preview

#Preview {
    MealCardView(
        dateString: "1월 2일 (목)",
        breakfastMenu: "토스트, 우유, 사과",
        lunchMenu: "김치찌개, 밥, 계란말이",
        dinnerMenu: "돈까스, 샐러드, 미소국",
        breakfastLikeCount: 10,
        lunchLikeCount: 25,
        dinnerLikeCount: 15,
        breakfastDislikeCount: 2,
        lunchDislikeCount: 5,
        dinnerDislikeCount: 3
    )
    .padding()
}
