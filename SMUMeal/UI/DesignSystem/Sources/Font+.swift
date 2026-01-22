//
//  Font+.swift
//  DesignSystem
//
//  Created by 김진혁 on 1/2/26.
//

import SwiftUI

// MARK: - Custom Font Extension
public extension Font {
    // 폰트 이름은 실제 폰트 파일의 PostScript 이름으로 변경 필요
    // 폰트 추가 후 registerFonts() 호출하고 아래 코드로 이름 확인:
    // UIFont.familyNames.forEach { print($0); UIFont.fontNames(forFamilyName: $0).forEach { print("  - \($0)") } }

    static func pretendard(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        let fontName: String
        switch weight {
        case .bold:
            fontName = "Pretendard-Bold"
        case .semibold:
            fontName = "Pretendard-SemiBold"
        case .medium:
            fontName = "Pretendard-Medium"
        case .light:
            fontName = "Pretendard-Light"
        case .thin:
            fontName = "Pretendard-Thin"
        default:
            fontName = "Pretendard-Regular"
        }
        return .custom(fontName, size: size)
    }
}
