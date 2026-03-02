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
    func postLike(type collectionType: String, for date: String, meal: MealType) async throws
    func postDislike(type collectionType: String, for date: String, meal: MealType) async throws
    func postUnlike(type collectionType: String, for date: String, meal: MealType) async throws
    func postUndislike(type collectionType: String, for date: String, meal: MealType) async throws
    func invalidateCache(for cafeteriaType: CafeteriaType, date: String)
}

private final class CafeteriaMenuWrapper {
    let menu: CafeteriaMenu
    init(_ menu: CafeteriaMenu) { self.menu = menu }
}

// Repository - 구현체
public final class MealRepository: MealRepositoryProtocol {
    private let client: APIClient
    private let cache = NSCache<NSString, CafeteriaMenuWrapper>()

    public init(client: APIClient = .shared) {
        self.client = client
    }

    private func cacheKey(for cafeteriaType: CafeteriaType, date: String) -> NSString {
        "\(cafeteriaType.collectionType)_\(date)" as NSString
    }

    public func fetchMeal(cafeteriaType: CafeteriaType, targetDate: String) async throws -> CafeteriaMenu {
        let key = cacheKey(for: cafeteriaType, date: targetDate)

        if let cached = cache.object(forKey: key) {
            print("[Cache] Hit: \(key)")
            return cached.menu
        }

        print("[Cache] Miss: \(key)")
        let request = FetchMenuRequest(cafeteriaType: cafeteriaType.collectionType, date: targetDate)
        var menu = try await client.send(request)
        menu.breakfastMenu = menu.breakfastMenu.replacingLiteralNewlines()
        menu.lunchMenu = menu.lunchMenu.replacingLiteralNewlines()
        menu.dinnerMenu = menu.dinnerMenu.replacingLiteralNewlines()

        cache.setObject(CafeteriaMenuWrapper(menu), forKey: key)
        return menu
    }

    public func invalidateCache(for cafeteriaType: CafeteriaType, date: String) {
        let key = cacheKey(for: cafeteriaType, date: date)
        cache.removeObject(forKey: key)
        print("[Cache] Invalidated: \(key)")
    }

    public func postLike(type collectionType: String, for date: String, meal: MealType) async throws {
        let request = LikeRequest(cafeteriaType: collectionType, date: date, meal: meal.rawValue)
        _ = try await client.send(request)
    }

    public func postDislike(type collectionType: String, for date: String, meal: MealType) async throws {
        let request = DislikeRequest(cafeteriaType: collectionType, date: date, meal: meal.rawValue)
        _ = try await client.send(request)
    }

    public func postUnlike(type collectionType: String, for date: String, meal: MealType) async throws {
        let request = UnlikeRequest(cafeteriaType: collectionType, date: date, meal: meal.rawValue)
        _ = try await client.send(request)
    }

    public func postUndislike(type collectionType: String, for date: String, meal: MealType) async throws {
        let request = UndislikeRequest(cafeteriaType: collectionType, date: date, meal: meal.rawValue)
        _ = try await client.send(request)
    }
}
