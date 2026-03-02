//
//  SettingInfoRow.swift
//  UIComponents
//
//  Created by 김진혁 on 2/16/26.
//

import SwiftUI
import DesignSystem

public struct SettingInfoRow: View {
    private let label: String
    private let value: String

    public init(label: String, value: String) {
        self.label = label
        self.value = value
    }

    public var body: some View {
        LabeledContent {
            Text(value)
                .font(.pretendard(size: 12, weight: .bold))
                .foregroundStyle(Color.gray01)
        } label: {
            Text(label)
                .font(.pretendard(size: 12, weight: .bold))
                .foregroundStyle(Color.gray01)
        }
    }
}
