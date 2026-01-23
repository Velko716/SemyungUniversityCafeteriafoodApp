//
//  MealTrailingToolbar.swift
//  Components
//
//  Created by 김진혁 on 1/22/26.
//

import SwiftUI
import DesignSystem

public struct MealTrailingToolbar<Destination: View>: ToolbarContent {
    private let destination: () -> Destination
    private let iconColor: Color

    public init(
        iconColor: Color = Color.gray01,
        @ViewBuilder destination: @escaping () -> Destination
    ) {
        self.iconColor = iconColor
        self.destination = destination
    }

    public var body: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            NavigationLink {
                destination()
            } label: {
                Image(systemName: "gearshape.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(iconColor)
            }
        }
    }
}

//#Preview {
//    NavigationStack {
//        Text("Sample")
//            .toolbar {
//                MealTrailingToolbar {
//                    Text("Settings View")
//                        .navigationTitle("Settings")
//                }
//            }
//    }
//}
