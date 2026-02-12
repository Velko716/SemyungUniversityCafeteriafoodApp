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
import FirebaseFirestore

public protocol MealRepositoryProtocol {
    func observeMeal(cafeteriaType: CafeteriaType, targetDate: String) -> AsyncThrowingStream<CafeteriaMenu, Error>
    func updateCount(cafeteriaType: CafeteriaType, targetDate: String, mealTime: MealTimeType, action: CountActionType, increment: Int) async throws
}

// Repository - 구현체
public struct MealRepository: MealRepositoryProtocol {
    private let firestore: FirestoreManager

    public init(firestore: FirestoreManager) {
        self.firestore = firestore
    }
    
//    public func fetchMeal(cafeteriaType: CafeteriaType, targetDate: String) async throws -> CafeteriaMenu {
//        // \\n -> \n 변경 로직 포함
//        switch cafeteriaType {
//        case .studentCafeteria:
//            var cafeteriaMenu: CafeteriaMenu = try await firestore.get(targetDate, from: .studentCafeteria)
//            cafeteriaMenu.breakfastMenu = cafeteriaMenu.breakfastMenu.replacingLiteralNewlines()
//            cafeteriaMenu.lunchMenu = cafeteriaMenu.lunchMenu.replacingLiteralNewlines()
//            cafeteriaMenu.dinnerMenu = cafeteriaMenu.dinnerMenu.replacingLiteralNewlines()
//            return cafeteriaMenu
//        case .selfServiceCafeteria:
//            var cafeteriaMenu: CafeteriaMenu = try await firestore.get(targetDate, from: .selfServiceCafeteria)
//            cafeteriaMenu.breakfastMenu = cafeteriaMenu.breakfastMenu.replacingLiteralNewlines()
//            cafeteriaMenu.lunchMenu = cafeteriaMenu.lunchMenu.replacingLiteralNewlines()
//            cafeteriaMenu.dinnerMenu = cafeteriaMenu.dinnerMenu.replacingLiteralNewlines()
//            return cafeteriaMenu
//        case .yejiDormitoryCafeteria:
//            var cafeteriaMenu: CafeteriaMenu = try await firestore.get(targetDate, from: .yejiDormitoryCafeteria)
//            cafeteriaMenu.breakfastMenu = cafeteriaMenu.breakfastMenu.replacingLiteralNewlines()
//            cafeteriaMenu.lunchMenu = cafeteriaMenu.lunchMenu.replacingLiteralNewlines()
//            cafeteriaMenu.dinnerMenu = cafeteriaMenu.dinnerMenu.replacingLiteralNewlines()
//            return cafeteriaMenu
//        }
//    }
    
    public func observeMeal(cafeteriaType: CafeteriaType, targetDate: String) -> AsyncThrowingStream<CafeteriaMenu, Error> {
        let collectionType: CollectionType = switch cafeteriaType {
        case .studentCafeteria: .studentCafeteria
        case .selfServiceCafeteria: .selfServiceCafeteria
        case .yejiDormitoryCafeteria: .yejiDormitoryCafeteria
        }

        return AsyncThrowingStream { continuation in
            let stream: AsyncThrowingStream<CafeteriaMenu, Error> = firestore.observe(targetDate, from: collectionType)

            Task {
                do {
                    for try await cafeteriaMenu in stream {
                        var menu = cafeteriaMenu
                        menu.breakfastMenu = menu.breakfastMenu.replacingLiteralNewlines()
                        menu.lunchMenu = menu.lunchMenu.replacingLiteralNewlines()
                        menu.dinnerMenu = menu.dinnerMenu.replacingLiteralNewlines()
                        continuation.yield(menu)
                    }
                    continuation.finish()
                } catch {
                    continuation.finish(throwing: error)
                }
            }
        }
    }

    public func updateCount(
        cafeteriaType: CafeteriaType,
        targetDate: String,
        mealTime: MealTimeType,
        action: CountActionType,
        increment: Int
    ) async throws {
        let collectionType: CollectionType = switch cafeteriaType {
        case .studentCafeteria: .studentCafeteria
        case .selfServiceCafeteria: .selfServiceCafeteria
        case .yejiDormitoryCafeteria: .yejiDormitoryCafeteria
        }

        let fieldKey = mealTime.fieldKey(for: action)

        try await firestore.updateFields(
            collection: collectionType,
            documentId: targetDate,
            asDictionary: [fieldKey: FieldValue.increment(Int64(increment))]
        )
    }
}
