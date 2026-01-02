//
//  CalendarButton.swift
//  Components
//
//  Created by 김진혁 on 1/2/26.
//

import SwiftUI

internal struct CalendarButton: View {
    
    internal init() {}
    
    var body: some View {
        Button {
            
        } label: {
            Image(systemName: "calendar")
                .foregroundStyle(Color.white)
                .background(
                    Circle().fill(Color.pink)
                )
        }
    }
}

#Preview {
    CalendarButton()
}
