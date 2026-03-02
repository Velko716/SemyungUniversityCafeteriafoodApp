//
//  ToastView.swift
//  UIComponents
//
//  Created by 김진혁 on 2/16/26.
//

import SwiftUI

public struct ToastView: View {
    var text: String
    
    public init(text: String) {
        self.text = text
    }
    
    public var body: some View {
        HStack {
            Text(text)
                .font(.pretendard(size: 12, weight: .bold))
                .foregroundStyle(Color.gray01)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity, minHeight: 43, alignment: .leading)
        }
        .padding(.leading, 16)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.blue01)
        )
        .onAppear {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        }
    }
}

#Preview {
    ToastView(text: "배고프다")
        .padding(.horizontal, 16)
}
