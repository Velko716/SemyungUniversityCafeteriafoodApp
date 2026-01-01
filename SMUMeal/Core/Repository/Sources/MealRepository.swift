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
    func fetchMeal(targetDate: String) async throws -> Menu
}

// Repository - 구현체
public struct MealRepository: MealRepositoryProtocol {
    private let firestore: FirestoreManager

    public init(firestore: FirestoreManager) {
        self.firestore = firestore
    }
    
    public func fetchMeal(targetDate: String) async throws -> Menu {
        try await firestore.get(targetDate, from: .studentCafeteria)
    }
}
