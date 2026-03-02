//
//  SettingNavigationRow.swift
//  UIComponents
//
//  Created by 김진혁 on 2/16/26.
//

import SwiftUI
import DesignSystem

public struct SettingNavigationRow: View {
    private let label: String

    public init(label: String) {
        self.label = label
    }

    public var body: some View {
        LabeledContent {
            Image(systemName: "chevron.right")
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(Color.gray01.opacity(0.7))
        } label: {
            Text(label)
                .font(.pretendard(size: 12, weight: .bold))
                .foregroundStyle(Color.gray01)
        }
    }
}
