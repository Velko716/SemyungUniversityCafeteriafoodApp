//
//  XmarkButton.swift
//  UIComponents
//
//  Created by 김진혁 on 2/16/26.
//

import SwiftUI

public struct XmarkButton: View {
    let action: () -> Void
    
    public init(
        action: @escaping () -> Void
    ) {
        self.action = action
    }

    public var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "xmark.circle.fill")
                .foregroundStyle(Color.gray01)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    XmarkButton() {}
}
