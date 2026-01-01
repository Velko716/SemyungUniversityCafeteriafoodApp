//
//  MealCarouselView.swift
//  Meal
//
//  Created by 김진혁 on 1/1/26.
//

import SwiftUI
import Repository

public struct MealCarouselView: View {
    @State private var viewModel: MealCarouselViewModel

    public init(repository: MealRepositoryProtocol) {
        _viewModel = State(initialValue: MealCarouselViewModel(repository: repository))
    }

    public var body: some View {
        Text("하이")
            .task {
                Task {
                    do {
                        try await viewModel.loadMeal()
                    } catch {
                        print("error")
                    }
                }
            }
    }
}

#Preview {
    MealCarouselView(repository: MockMealRepository())
}
