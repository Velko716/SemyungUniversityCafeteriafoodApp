//
//  MealContentView.swift
//  Components
//
//  Created by 김진혁 on 1/22/26.
//

import SwiftUI

internal struct MealContentView: View {
    let menu: String
    let likeCount: Int
    let disLikeCount: Int
    let menuFontSize: CGFloat

    let buttonIconSize: CGFloat
    let buttonFontSize: CGFloat
    let buttonVerticalPadding: CGFloat
    let buttonHorizontalPadding: CGFloat

    let cardHeight: CGFloat
    let verticalPadding: CGFloat

    let isLoading: Bool

    let onLike: () -> Void
    let onDislike: () -> Void

    var body: some View {
        Group {
            if isLoading {
                SkeletonView(RoundedRectangle(cornerRadius: 8))
            } else {
                HStack {
                    Text(menu)
                        .font(.pretendard(size: menuFontSize, weight: .medium))
                        .foregroundStyle(Color.gray01)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    // MARK: - 식단 등록되지 않았을 때, 버튼 숨기기
                    if menu == "아직 식단이 등록되지 않았습니다." {
                        EmptyView()
                    } else {
                        HStack {
                            CountButton(
                                countButtonType: .like,
                                count: likeCount,
                                iconSize: buttonIconSize,
                                fontSize: buttonFontSize,
                                verticalPadding: buttonVerticalPadding,
                                horizontalPadding: buttonHorizontalPadding,
                                cornerRadius: 16) {
                                    onLike()
                                }

                            CountButton(
                                countButtonType: .disLike,
                                count: disLikeCount,
                                iconSize: buttonIconSize,
                                fontSize: buttonFontSize,
                                verticalPadding: buttonVerticalPadding,
                                horizontalPadding: buttonHorizontalPadding,
                                cornerRadius: 16) {
                                    onDislike()
                                }
                        }
                    }
                }
                .padding(.horizontal, 8)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray02)
                )
            }
        }
        .frame(height: cardHeight + verticalPadding * 2)
    }
}

#Preview {
    MealContentView(
        menu: "아침메뉴표시되는곳",
        likeCount: 10,
        disLikeCount: 10,
        menuFontSize: 10,
        buttonIconSize: 10,
        buttonFontSize: 10,
        buttonVerticalPadding: 10,
        buttonHorizontalPadding: 10,
        cardHeight: 10,
        verticalPadding: 10,
        isLoading: false,
        onLike: {},
        onDislike: {}
    )
}
