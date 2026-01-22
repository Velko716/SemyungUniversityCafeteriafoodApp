//
//  DateHeaderView.swift
//  Components
//
//  Created by 김진혁 on 1/2/26.
//

import SwiftUI

internal struct DateHeaderView: View {
    @State var dateString: String
    let dateStringFontSize: CGFloat
    let action: () -> Void
    
    internal init(
        dateString: String,
        dateStringFontSize: CGFloat,
        action: @escaping () -> Void
    ) {
        self.dateString = dateString
        self.dateStringFontSize = dateStringFontSize
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Text(dateString)
                    .font(.pretendard(size: dateStringFontSize, weight: .bold))
                    .foregroundStyle(Color.black)
                
                Spacer().frame(width: 4)
                
                Image(systemName: "calendar")
                    .font(.pretendard(size: dateStringFontSize, weight: .bold))
                    .foregroundStyle(Color.black)
            }
        }
    }
}

#Preview {
    DateHeaderView(dateString: "2025년 1월 1일 (수)", dateStringFontSize: 30) { }
}
