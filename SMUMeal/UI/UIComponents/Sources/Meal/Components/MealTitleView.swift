//
//  MealTitleView.swift
//  Components
//
//  Created by 김진혁 on 1/22/26.
//

import SwiftUI

internal struct MealTitleView: View {
    let titleTypeText: String
    let timeText: String
    let titleFontSize: CGFloat
    let menuFontSize: CGFloat
    var isHighlighted: Bool = false

    private var titleColor: Color {
        isHighlighted ? Color.blue01 : Color.gray01
    }

    var body: some View {
        HStack {
            Text(titleTypeText)
                .font(.pretendard(size: titleFontSize, weight: .bold))
                .foregroundStyle(titleColor)

            Spacer().frame(width: 8)

            Image(systemName: "stopwatch")
                .font(.pretendard(size: menuFontSize, weight: .bold))
                .foregroundStyle(titleColor)

            Spacer().frame(width: 4)

            Text(timeText)
                .font(.pretendard(size: menuFontSize, weight: .bold))
                .foregroundStyle(titleColor)

            Spacer()
        }
    }
}

#Preview {
    MealTitleView(
        titleTypeText: "아침",
        timeText: "이용시간: 8:30 ~ 9:20 (토요일: x)",
        titleFontSize: 20,
        menuFontSize: 10
    )
}
