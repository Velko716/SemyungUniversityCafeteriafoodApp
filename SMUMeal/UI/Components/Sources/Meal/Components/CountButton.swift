//
//  CountButton.swift
//  Components
//
//  Created by 김진혁 on 1/20/26.
//

import SwiftUI

public enum CountButtonType {
    case like
    case disLike
    
    public var countButtonImage: String {
        switch self {
        case .like:
            return "hand.thumbsup"
        case .disLike:
            return "hand.thumbsdown"
        }
    }
}

public struct CountButton: View {
    let countButtonType: CountButtonType
    let count: Int
    let iconSize: CGFloat
    let fontSize: CGFloat
    let verticalPadding: CGFloat
    let horizontalPadding: CGFloat
    let cornerRadius: CGFloat
    let action: () -> Void

    public init(
        countButtonType: CountButtonType,
        count: Int,
        iconSize: CGFloat,
        fontSize: CGFloat,
        verticalPadding: CGFloat,
        horizontalPadding: CGFloat,
        cornerRadius: CGFloat,
        action: @escaping () -> Void
    ) {
        self.countButtonType = countButtonType
        self.count = count
        self.iconSize = iconSize
        self.fontSize = fontSize
        self.verticalPadding = verticalPadding
        self.horizontalPadding = horizontalPadding
        self.cornerRadius = cornerRadius
        self.action = action
    }

    public var body: some View {
        HStack {
            Button(action: action) {
                HStack(spacing: iconSize * 0.5) {
                    Image(systemName: countButtonType.countButtonImage)
                        .font(.pretendard(size: iconSize, weight: .medium))
                        .foregroundStyle(Color.black)
                    Text("\(count)")
                        .font(.pretendard(size: fontSize, weight: .medium))
                        .foregroundStyle(Color.black)
                }
                .padding(.vertical, verticalPadding)
                .padding(.horizontal, horizontalPadding)
                .background(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(Color.yellow)
                )
            }
        }
    }
}

//#Preview {
//    CountButton(countButtonType: .like, count: 12) {
//        print("action")
//    }
//    
//    CountButton(countButtonType: .disLike, count: 8) {
//        print("action")
//    }
//}
