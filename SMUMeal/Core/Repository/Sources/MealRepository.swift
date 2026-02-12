//
//  MealRepository.swift
//  Repository
//
//  Created by 김진혁 on 1/2/26.
//

import Foundation
import Domain
import Network
import Utility

public protocol MealRepositoryProtocol {
    func fetchMeal(cafeteriaType: CafeteriaType, targetDate: String) async throws -> CafeteriaMenu
}

// Repository - 구현체
public struct MealRepository: MealRepositoryProtocol {
    private let api: CafeteriaAPI

    public init(api: CafeteriaAPI = CafeteriaAPI()) {
        self.api = api
    }

    public func fetchMeal(cafeteriaType: CafeteriaType, targetDate: String) async throws -> CafeteriaMenu {
        var menu = try await api.fetchMenu(for: targetDate)
        menu.breakfastMenu = menu.breakfastMenu.replacingLiteralNewlines()
        menu.lunchMenu = menu.lunchMenu.replacingLiteralNewlines()
        menu.dinnerMenu = menu.dinnerMenu.replacingLiteralNewlines()
        return menu
    }
}
