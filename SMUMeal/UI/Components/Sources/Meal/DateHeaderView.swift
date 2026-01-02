//
//  DateHeaderView.swift
//  Components
//
//  Created by 김진혁 on 1/2/26.
//

import SwiftUI

internal struct DateHeaderView: View {
    @State var dateString: String
    
    internal init(dateString: String) {
        self.dateString = dateString
    }
    
    var body: some View {
        Text(dateString)
            .font(.title)
            .foregroundStyle(Color.black)
    }
}

#Preview {
    DateHeaderView(dateString: "2025년 1월 1일 (수)")
}
