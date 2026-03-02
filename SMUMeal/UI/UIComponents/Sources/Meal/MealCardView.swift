//
//  CarouselView.swift
//  Components
//
//  Created by 김진혁 on 1/2/26.
//

import SwiftUI
import DesignSystem
import Domain

// MARK: - MealCardView (단일 카드)
public struct MealCardView: View {
    public let dateString: String
    public let breakfastMenu: String
    public let lunchMenu: String
    public let dinnerMenu: String
    public let reactions: [String: Reaction]
    public let isLoading: Bool
    public let highlightedMealType: MealType?
    public let contentOffset: CGFloat

    // @State private var isCalendarPresented: Bool = false
    @Binding private var selectedDate: Date

    private let onBreakfastLike: () -> Void
    private let onBreakfastDislike: () -> Void
    private let onLunchLike: () -> Void
    private let onLunchDislike: () -> Void
    private let onDinnerLike: () -> Void
    private let onDinnerDislike: () -> Void

    public init(
        dateString: String,
        breakfastMenu: String,
        lunchMenu: String,
        dinnerMenu: String,
        reactions: [String: Reaction] = [:],
        isLoading: Bool = false,
        highlightedMealType: MealType? = nil,
        contentOffset: CGFloat = 0,
        selectedDate: Binding<Date>,
        onBreakfastLike: @escaping () -> Void,
        onBreakfastDislike: @escaping () -> Void,
        onLunchLike: @escaping () -> Void,
        onLunchDislike: @escaping () -> Void,
        onDinnerLike: @escaping () -> Void,
        onDinnerDislike: @escaping () -> Void
    ) {
        self.dateString = dateString
        self.breakfastMenu = breakfastMenu
        self.lunchMenu = lunchMenu
        self.dinnerMenu = dinnerMenu
        self.reactions = reactions
        self.isLoading = isLoading
        self.highlightedMealType = highlightedMealType
        self.contentOffset = contentOffset
        self._selectedDate = selectedDate
        self.onBreakfastLike = onBreakfastLike
        self.onBreakfastDislike = onBreakfastDislike
        self.onLunchLike = onLunchLike
        self.onLunchDislike = onLunchDislike
        self.onDinnerLike = onDinnerLike
        self.onDinnerDislike = onDinnerDislike
    }

    // MARK: - 고정 크기 값
    private let cardHeight: CGFloat = 150
    private let verticalPadding: CGFloat = 8
    private let titleFontSize: CGFloat = 18
    private let menuFontSize: CGFloat = 14
    private let buttonIconSize: CGFloat = 14
    private let buttonFontSize: CGFloat = 12
    private let buttonVerticalPadding: CGFloat = 6
    private let buttonHorizontalPadding: CGFloat = 14

    public var body: some View {
        VStack {

             Spacer()

            // MARK: - 아침
            MealTitleView(
                titleTypeText: "아침",
                timeText: "이용시간: 8:30 ~ 9:20 (토요일: x)",
                titleFontSize: titleFontSize,
                menuFontSize: menuFontSize,
                isHighlighted: highlightedMealType == .breakfast
            )

            Spacer().frame(height: 8)

            MealContentView(
                menu: breakfastMenu,
                likeCount: reactions["breakfast"]?.likeCount ?? 0,
                disLikeCount: reactions["breakfast"]?.dislikeCount ?? 0,
                menuFontSize: menuFontSize,
                buttonIconSize: buttonIconSize,
                buttonFontSize: buttonFontSize,
                buttonVerticalPadding: buttonVerticalPadding,
                buttonHorizontalPadding: buttonHorizontalPadding,
                cardHeight: cardHeight,
                verticalPadding: verticalPadding,
                isLoading: isLoading,
                isHighlighted: highlightedMealType == .breakfast,
                onLike: onBreakfastLike,
                onDislike: onBreakfastDislike
            )
            .offset(x: contentOffset)
            .clipped()

            Spacer()

            // MARK: - 점심
            MealTitleView(
                titleTypeText: "점심",
                timeText: "이용시간: 11:00 ~ 14:30 (토요일: 12:00 ~ 13:00)",
                titleFontSize: titleFontSize,
                menuFontSize: menuFontSize,
                isHighlighted: highlightedMealType == .lunch
            )

            Spacer().frame(height: 8)

            MealContentView(
                menu: lunchMenu,
                likeCount: reactions["lunch"]?.likeCount ?? 0,
                disLikeCount: reactions["lunch"]?.dislikeCount ?? 0,
                menuFontSize: menuFontSize,
                buttonIconSize: buttonIconSize,
                buttonFontSize: buttonFontSize,
                buttonVerticalPadding: buttonVerticalPadding,
                buttonHorizontalPadding: buttonHorizontalPadding,
                cardHeight: cardHeight,
                verticalPadding: verticalPadding,
                isLoading: isLoading,
                isHighlighted: highlightedMealType == .lunch,
                onLike: onLunchLike,
                onDislike: onLunchDislike
            )
            .offset(x: contentOffset)
            .clipped()

            Spacer()

            // MARK: - 저녁
            MealTitleView(
                titleTypeText: "저녁",
                timeText: "이용시간: 17:30 ~ 18:50 (토요일: 17:00 ~ 18:00)",
                titleFontSize: titleFontSize,
                menuFontSize: menuFontSize,
                isHighlighted: highlightedMealType == .dinner
            )

            Spacer().frame(height: 8)

            MealContentView(
                menu: dinnerMenu,
                likeCount: reactions["dinner"]?.likeCount ?? 0,
                disLikeCount: reactions["dinner"]?.dislikeCount ?? 0,
                menuFontSize: menuFontSize,
                buttonIconSize: buttonIconSize,
                buttonFontSize: buttonFontSize,
                buttonVerticalPadding: buttonVerticalPadding,
                buttonHorizontalPadding: buttonHorizontalPadding,
                cardHeight: cardHeight,
                verticalPadding: verticalPadding,
                isLoading: isLoading,
                isHighlighted: highlightedMealType == .dinner,
                onLike: onDinnerLike,
                onDislike: onDinnerDislike
            )
            .offset(x: contentOffset)
            .clipped()

            Spacer()

        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        ZStack {
            Color.navy01.ignoresSafeArea()
            MealCardView(
                dateString: "1월 2일 (목)",
                breakfastMenu: "토스트\n우유\n사과\n토스트\n우유\n사과\n사과",
                lunchMenu: "김치찌개\n밥\n계란말이",
                dinnerMenu: "돈까스\n샐러드\n미소국",
                reactions: [
                    "breakfast": Reaction(likeCount: 10, dislikeCount: 2),
                    "lunch": Reaction(likeCount: 25, dislikeCount: 5),
                    "dinner": Reaction(likeCount: 15, dislikeCount: 3)
                ],
                selectedDate: .constant(Date()),
                onBreakfastLike: { print("breakfast like") },
                onBreakfastDislike: { print("breakfast dislike") },
                onLunchLike: { print("lunch like") },
                onLunchDislike: { print("lunch dislike") },
                onDinnerLike: { print("dinner like") },
                onDinnerDislike: { print("dinner dislike") }
            )
            .padding(16)
            .navigationTitle("학생회관_학생식당")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
