//
//  CarouselView.swift
//  Components
//
//  Created by 김진혁 on 1/2/26.
//

import SwiftUI
import DesignSystem


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

    @State private var isCalendarPresented: Bool = false
    @Binding private var selectedDate: Date

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
        selectedDate: Binding<Date>
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
        self._selectedDate = selectedDate
    }

    public var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let cardHeight = height * 0.22
            let verticalPadding = height * 0.01

            // 폰트 크기
            let dateFontSize = width * 0.045
            let titleFontSize = width * 0.05
            let menuFontSize = width * 0.036

            // 버튼 크기
            let buttonIconSize = width * 0.04
            let buttonFontSize = width * 0.032
            let buttonVerticalPadding = height * 0.01
            let buttonHorizontalPadding = width * 0.04

            VStack {
                DateHeaderView(dateString: dateString, dateStringFontSize: dateFontSize) {
                    self.isCalendarPresented = true
                }
                Spacer()
                
                // MARK: - 아침
                MealTitleView(
                    titleTypeText: "아침",
                    timeText: "이용시간: 8:30 ~ 9:20 (토요일: x)",
                    titleFontSize: titleFontSize,
                    menuFontSize: menuFontSize
                )
                
                Spacer().frame(height: 8)
                
                MealContentView(
                    menu: breakfastMenu,
                    likeCount: breakfastLikeCount,
                    disLikeCount: breakfastDislikeCount,
                    menuFontSize: menuFontSize,
                    buttonIconSize: buttonIconSize,
                    buttonFontSize: buttonFontSize,
                    buttonVerticalPadding: buttonVerticalPadding,
                    buttonHorizontalPadding: buttonHorizontalPadding,
                    cardHeight: cardHeight,
                    verticalPadding: verticalPadding
                )
                
                Spacer()
                
                // MARK: - 점심
                MealTitleView(
                    titleTypeText: "점심",
                    timeText: "이용시간: 11:00 ~ 14:30 (토요일: 12:00 ~ 13:00)",
                    titleFontSize: titleFontSize,
                    menuFontSize: menuFontSize
                )
                
                Spacer().frame(height: 8)
                
                MealContentView(
                    menu: lunchMenu,
                    likeCount: lunchLikeCount,
                    disLikeCount: lunchDislikeCount,
                    menuFontSize: menuFontSize,
                    buttonIconSize: buttonIconSize,
                    buttonFontSize: buttonFontSize,
                    buttonVerticalPadding: buttonVerticalPadding,
                    buttonHorizontalPadding: buttonHorizontalPadding,
                    cardHeight: cardHeight,
                    verticalPadding: verticalPadding
                )
                
                Spacer()

                // MARK: - 저녁
                MealTitleView(
                    titleTypeText: "저녁",
                    timeText: "이용시간: 17:30 ~ 18:50 (토요일: 17:00 ~ 18:00)",
                    titleFontSize: titleFontSize,
                    menuFontSize: menuFontSize
                )

                Spacer().frame(height: 8)
                
                MealContentView(
                    menu: dinnerMenu,
                    likeCount: dinnerLikeCount,
                    disLikeCount: dinnerDislikeCount,
                    menuFontSize: menuFontSize,
                    buttonIconSize: buttonIconSize,
                    buttonFontSize: buttonFontSize,
                    buttonVerticalPadding: buttonVerticalPadding,
                    buttonHorizontalPadding: buttonHorizontalPadding,
                    cardHeight: cardHeight,
                    verticalPadding: verticalPadding
                )
            }
            .popover(isPresented: $isCalendarPresented, arrowEdge: .bottom) {
                DatePicker(
                    "",
                    selection: $selectedDate,
                    displayedComponents: .date
                )
                .datePickerStyle(.graphical)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        MealCardView(
            dateString: "1월 2일 (목)",
            breakfastMenu: "토스트\n우유\n사과\n토스트\n우유\n사과\n사과",
            lunchMenu: "김치찌개\n밥\n계란말이",
            dinnerMenu: "돈까스\n샐러드\n미소국",
            breakfastLikeCount: 10,
            lunchLikeCount: 25,
            dinnerLikeCount: 15,
            breakfastDislikeCount: 2,
            lunchDislikeCount: 5,
            dinnerDislikeCount: 3,
            selectedDate: .constant(Date())
        )
        .padding(16)
        .navigationTitle("학생회관_학생식당")
        .navigationBarTitleDisplayMode(.inline)
    }
}

