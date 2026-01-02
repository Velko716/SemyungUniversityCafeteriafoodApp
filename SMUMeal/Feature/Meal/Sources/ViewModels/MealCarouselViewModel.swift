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
    internal var choiceDate: Date = Date() // 오늘날짜 Date (디폴트값: 오늘 날짜)
    internal var toolBarType: CafeteriaType = .studentCafeteria // FIXME: - 수정하기 (초기값 AppStorege로)
    
    internal init(repository: MealRepositoryProtocol) {
        self.repository = repository
    }
    
    func loadMeal(targetDate: Date) async throws -> CafeteriaMenu {
        return try await repository.fetchMeal(cafeteriaType: self.toolBarType, targetDate: targetDate.fullDateString)
    }
}
