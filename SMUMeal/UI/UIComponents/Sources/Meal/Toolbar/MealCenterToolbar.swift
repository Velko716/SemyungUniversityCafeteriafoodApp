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
                HStack(spacing: 6) {
                    Text(displayName(cafeteriaType))
                        .font(.pretendard(size: 18, weight: .medium))
                        .foregroundStyle(Color.white01)

                    Image(systemName: "arrowtriangle.down.fill")
                        .font(.system(size: 8, weight: .bold))
                        .foregroundStyle(Color.white01.opacity(0.7))
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(
                    Capsule()
                        .fill(Color.white01.opacity(0.1))
                )
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
