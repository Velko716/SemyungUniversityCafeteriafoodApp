//
//  MealCenterToolbar.swift
//  Components
//
//  Created by 김진혁 on 1/2/26.
//

import SwiftUI

public struct MealCenterToolbar<T: RawRepresentable & CaseIterable>: ToolbarContent where T.RawValue == String {
    private let cafeteriaType: T
    private let displayName: (T) -> String
    private let selectedType: (T) -> Void
    
    public init(
        cafeteriaType: T,
        displayName: @escaping (T) -> String,
        selectedType: @escaping (T) -> Void
    ) {
        self.cafeteriaType = cafeteriaType
        self.displayName = displayName
        self.selectedType = selectedType
    }
    
    public var body: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Menu {
                ForEach(Array(T.allCases), id: \.rawValue) { type in
                    Button(displayName(type)) {
                        selectedType(type)
                    }
                }
            } label: {
                HStack {
                    Text(displayName(cafeteriaType))
                        .font(.pretendard(size: 18, weight: .medium))
                        .foregroundStyle(Color.black) // FIXME: - 컬러 수정
                    
                    Spacer().frame(width: 2)
                    
                    Image(systemName: "arrowtriangle.down.fill")
                        .font(.pretendard(size: 14, weight: .medium))
                        .foregroundStyle(Color.black01) // FIXME: - 컬러 수정
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        VStack {
            Text("MealCenterToolbar")
        }
        .toolbar {
            // MealCenterToolbar(cafeteriaType: <#T##RawRepresentable#>)
        }
    }
}
