//
//  MockMealRepository.swift
//  Repository
//
//  Created by 김진혁 on 1/2/26.
//

#if DEBUG
import Foundation
import Network
import Domain

public struct MockMealRepository: MealRepositoryProtocol {

    public init() {}

    public func observeMeal(cafeteriaType: CafeteriaType, targetDate: String) -> AsyncThrowingStream<CafeteriaMenu, Error> {
        AsyncThrowingStream { continuation in
            continuation.yield(CafeteriaMenu(
                breakfastMenu: "토스트, 우유, 사과",
                lunchMenu: "김치찌개, 밥, 계란말이",
                dinnerMenu: "돈까스, 샐러드, 미소국",
                breakfastLikeCount: 10,
                lunchLikeCount: 25,
                dinnerLikeCount: 15,
                breakfastDislikeCount: 2,
                lunchDislikeCount: 5,
                dinnerDislikeCount: 3
            ))
        }
    }

    public func updateCount(
        cafeteriaType: CafeteriaType,
        targetDate: String,
        mealTime: MealTimeType,
        action: CountActionType,
        increment: Int
    ) async throws {
        print("[Mock] updateCount: \(mealTime.fieldKey(for: action)), increment: \(increment)")
    }
}
#endif
