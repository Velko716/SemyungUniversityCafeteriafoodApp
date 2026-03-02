//
//  MockMealRepository.swift
//  Repository
//
//  Created by 김진혁 on 1/2/26.
//

#if DEBUG
import Foundation
import Domain

public struct MockMealRepository: MealRepositoryProtocol {

    public init() {}

    public func fetchMeal(cafeteriaType: CafeteriaType, targetDate: String) async throws -> CafeteriaMenu {
        CafeteriaMenu(
            breakfastMenu: "토스트, 우유, 사과",
            lunchMenu: "김치찌개, 밥, 계란말이",
            dinnerMenu: "돈까스, 샐러드, 미소국",
            reactions: [
                "breakfast": Reaction(likeCount: 10, dislikeCount: 2),
                "lunch": Reaction(likeCount: 25, dislikeCount: 5),
                "dinner": Reaction(likeCount: 15, dislikeCount: 3),
            ]
        )
    }
    
    public func postDislike(type collectionType: String, for date: String, meal: Domain.MealType) async throws {
        
    }
    
    public func postLike(type collectionType: String, for date: String, meal: MealType) async throws {
        
    }
    
    public func postUnlike(type collectionType: String, for date: String, meal: MealType) async throws {
    }

    public func postUndislike(type collectionType: String, for date: String, meal: MealType) async throws {
    }

    public func invalidateCache(for cafeteriaType: CafeteriaType, date: String) {}
}
#endif
