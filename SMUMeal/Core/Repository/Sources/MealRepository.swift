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
    private let firestore: FirestoreManager

    public init(firestore: FirestoreManager) {
        self.firestore = firestore
    }
    
    public func fetchMeal(cafeteriaType: CafeteriaType, targetDate: String) async throws -> CafeteriaMenu {
        // \\n -> \n 변경 로직 포함
        switch cafeteriaType {
        case .studentCafeteria:
            var cafeteriaMenu: CafeteriaMenu = try await firestore.get(targetDate, from: .studentCafeteria)
            cafeteriaMenu.breakfastMenu = cafeteriaMenu.breakfastMenu.replacingLiteralNewlines()
            cafeteriaMenu.lunchMenu = cafeteriaMenu.lunchMenu.replacingLiteralNewlines()
            cafeteriaMenu.dinnerMenu = cafeteriaMenu.dinnerMenu.replacingLiteralNewlines()
            return cafeteriaMenu
        case .selfServiceCafeteria:
            var cafeteriaMenu: CafeteriaMenu = try await firestore.get(targetDate, from: .selfServiceCafeteria)
            cafeteriaMenu.breakfastMenu = cafeteriaMenu.breakfastMenu.replacingLiteralNewlines()
            cafeteriaMenu.lunchMenu = cafeteriaMenu.lunchMenu.replacingLiteralNewlines()
            cafeteriaMenu.dinnerMenu = cafeteriaMenu.dinnerMenu.replacingLiteralNewlines()
            return cafeteriaMenu
        case .yejiDormitoryCafeteria:
            var cafeteriaMenu: CafeteriaMenu = try await firestore.get(targetDate, from: .yejiDormitoryCafeteria)
            cafeteriaMenu.breakfastMenu = cafeteriaMenu.breakfastMenu.replacingLiteralNewlines()
            cafeteriaMenu.lunchMenu = cafeteriaMenu.lunchMenu.replacingLiteralNewlines()
            cafeteriaMenu.dinnerMenu = cafeteriaMenu.dinnerMenu.replacingLiteralNewlines()
            return cafeteriaMenu
        }
    }
}
