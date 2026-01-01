//
//  MealCarouselViewModel.swift
//  Meal
//
//  Created by 김진혁 on 1/1/26.
//

import Foundation
import Repository
import Utility

@Observable
internal final class MealCarouselViewModel {
    private let repository: MealRepositoryProtocol
    private let date = Date()

    init(repository: MealRepositoryProtocol) {
        self.repository = repository
    }

    func loadMeal() async throws {
        let meal = try await repository.fetchMeal(targetDate: "2026-01-01")
        //print("date.fullDateString: \(date.fullDateString)")
        print(meal.breakfastMenu)
    }
}
