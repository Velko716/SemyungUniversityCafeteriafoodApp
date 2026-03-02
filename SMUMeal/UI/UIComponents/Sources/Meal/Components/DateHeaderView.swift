//
//  DateHeaderView.swift
//  Components
//
//  Created by 김진혁 on 1/2/26.
//

import SwiftUI

public struct DateHeaderView: View {
    let dateString: String
    let action: () -> Void
    
    public init(
        dateString: String,
        action: @escaping () -> Void
    ) {
        self.dateString = dateString
        self.action = action
    }
    
    public var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Text(dateString)
                    .font(.pretendard(size: 16, weight: .bold))
                    .foregroundStyle(Color.gray01)
                
                Spacer().frame(width: 4)
                
                Image(systemName: "calendar")
                    .font(.pretendard(size: 16, weight: .bold))
                    .foregroundStyle(Color.gray01)
            }
        }
    }
}

#Preview {
    DateHeaderView(dateString: "2025년 1월 1일 (수)") { }
}
