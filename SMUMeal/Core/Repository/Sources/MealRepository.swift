//
//  MealRepository.swift
//  Repository
//
//  Created by 김진혁 on 1/2/26.
//

import Foundation
import Domain
import Network

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
        switch cafeteriaType {
        case .studentCafeteria:
            return try await firestore.get(targetDate, from: .studentCafeteria)
        case .selfServiceCafeteria:
            return try await firestore.get(targetDate, from: .selfServiceCafeteria)
        case .yejiDormitoryCafeteria:
            return try await firestore.get(targetDate, from: .yejiDormitoryCafeteria)
        }
    }
}
