//
//  CalendarButton.swift
//  Components
//
//  Created by 김진혁 on 1/2/26.
//

import SwiftUI

internal struct CalendarButton: View {
    let action: () -> Void
    
    internal init(
        action: @escaping () -> Void
    ) {
        self.action = action
    }

    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "calendar")
                .foregroundStyle(Color.white)
                .padding(10)
                .background(
                    Circle()
                        .fill(Color.pink)
                )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    CalendarButton() {}
}
