//
//  MealToolbar.swift
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
                Text(displayName(cafeteriaType))
                    .font(.callout) // FIXME: - 폰트 수정
                    .foregroundStyle(Color.black) // FIXME: - 컬러 수정
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
