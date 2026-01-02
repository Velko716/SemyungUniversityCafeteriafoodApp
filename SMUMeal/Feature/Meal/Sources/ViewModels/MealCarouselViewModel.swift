//
//  MealCarouselViewModel.swift
//  Meal
//
//  Created by 김진혁 on 1/1/26.
//

import Foundation
import Repository
import Utility
import Network
import Domain

@Observable
internal final class MealCarouselViewModel {
    private let repository: MealRepositoryProtocol
    internal var choiceDate: Date = Date()
    internal var toolBarType: CafeteriaType = .studentCafeteria {
        didSet {
            UserDefaults.standard.set(toolBarType.rawValue, forKey: "lastCafeteriaType")
        }
    }

    internal init(repository: MealRepositoryProtocol) {
        self.repository = repository
        if let saved = UserDefaults.standard.string(forKey: "lastCafeteriaType"),
           let type = CafeteriaType(rawValue: saved) {
            self.toolBarType = type
        }
    }
    
    func loadMeal(targetDate: Date) async throws -> CafeteriaMenu {
        return try await repository.fetchMeal(cafeteriaType: self.toolBarType, targetDate: targetDate.fullDateString)
    }
}
