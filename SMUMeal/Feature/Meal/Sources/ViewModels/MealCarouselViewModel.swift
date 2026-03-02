//
//  MealCarouselViewModel.swift
//  Meal
//
//  Created by 김진혁 on 1/1/26.
//

import Foundation
import Repository
import Domain
import UIComponents

@Observable
internal final class MealCarouselViewModel {
    private let repository: MealRepositoryProtocol
    
    internal var isLoading: Bool = false
    internal var toastMessage: String?
    
    internal var menu: CafeteriaMenu = .init(
        breakfastMenu: "",
        lunchMenu: "",
        dinnerMenu: ""
    )
    
    internal var choiceDate: Date = Date()
    
    internal var toolBarType: CafeteriaType = .studentCafeteria {
        didSet {
            UserDefaults.standard.set(toolBarType.rawValue, forKey: "lastCafeteriaType")
        }
    }
    
    private func voteKey(mealType: MealType, action: MealActionType) -> String {
        "\(toolBarType.collectionType)_\(choiceDate.fullDateString)_\(mealType.rawValue)_\(action)"
    }
    
    internal init(repository: MealRepositoryProtocol) {
        self.repository = repository
        if let saved = UserDefaults.standard.string(forKey: "lastCafeteriaType"),
           let type = CafeteriaType(rawValue: saved) {
            self.toolBarType = type
        }
    }
    
    /// 메뉴 데이터 가져오기
    internal func fetchMeal() async {
        self.isLoading = true
        
        defer { self.isLoading = false }
        
        do {
            let cafeteriaMenu = try await repository.fetchMeal(
                cafeteriaType: toolBarType,
                targetDate: choiceDate.fullDateString
            )
            await MainActor.run {
                self.menu = cafeteriaMenu
            }
        } catch {
            print("Fetch error: \(error)")
            let fallback = "아직 식단이 등록되지 않았습니다."
            await MainActor.run {
                self.menu = CafeteriaMenu(
                    breakfastMenu: fallback,
                    lunchMenu: fallback,
                    dinnerMenu: fallback
                )
            }
        }
    }
    
    internal func likeUp(mealType: MealType) async {
        let likeKey = voteKey(mealType: mealType, action: .like)
        let dislikeKey = voteKey(mealType: mealType, action: .dislike)
        let hasLiked = UserDefaults.standard.bool(forKey: likeKey)
        let hasDisliked = UserDefaults.standard.bool(forKey: dislikeKey)

        do {
            var likeDelta = 0
            var dislikeDelta = 0

            if hasLiked {
                try await repository.postUnlike(type: toolBarType.collectionType, for: choiceDate.fullDateString, meal: mealType)
                UserDefaults.standard.removeObject(forKey: likeKey)
                likeDelta = -1
                showToast("좋아요를 취소했습니다.")
            } else {
                if hasDisliked {
                    try await repository.postUndislike(type: toolBarType.collectionType, for: choiceDate.fullDateString, meal: mealType)
                    UserDefaults.standard.removeObject(forKey: dislikeKey)
                    dislikeDelta = -1
                }
                try await repository.postLike(type: toolBarType.collectionType, for: choiceDate.fullDateString, meal: mealType)
                UserDefaults.standard.set(true, forKey: likeKey)
                likeDelta = 1
                showToast("좋아요를 눌렀습니다.")
            }

            repository.invalidateCache(for: toolBarType, date: choiceDate.fullDateString)
            updateReactionLocally(mealType: mealType, likeDelta: likeDelta, dislikeDelta: dislikeDelta)
        } catch {
            print("error: \(error.localizedDescription)")
        }
    }

    internal func dislikeUp(mealType: MealType) async {
        let likeKey = voteKey(mealType: mealType, action: .like)
        let dislikeKey = voteKey(mealType: mealType, action: .dislike)
        let hasLiked = UserDefaults.standard.bool(forKey: likeKey)
        let hasDisliked = UserDefaults.standard.bool(forKey: dislikeKey)

        do {
            var likeDelta = 0
            var dislikeDelta = 0

            if hasDisliked {
                try await repository.postUndislike(type: toolBarType.collectionType, for: choiceDate.fullDateString, meal: mealType)
                UserDefaults.standard.removeObject(forKey: dislikeKey)
                dislikeDelta = -1
                showToast("싫어요를 취소했습니다.")
            } else {
                if hasLiked {
                    try await repository.postUnlike(type: toolBarType.collectionType, for: choiceDate.fullDateString, meal: mealType)
                    UserDefaults.standard.removeObject(forKey: likeKey)
                    likeDelta = -1
                }
                try await repository.postDislike(type: toolBarType.collectionType, for: choiceDate.fullDateString, meal: mealType)
                UserDefaults.standard.set(true, forKey: dislikeKey)
                dislikeDelta = 1
                showToast("싫어요를 눌렀습니다.")
            }

            repository.invalidateCache(for: toolBarType, date: choiceDate.fullDateString)
            updateReactionLocally(mealType: mealType, likeDelta: likeDelta, dislikeDelta: dislikeDelta)
        } catch {
            print("error: \(error.localizedDescription)")
        }
    }

    private func showToast(_ message: String) {
        toastMessage = message
    }

    // MARK: - Private

    private func updateReactionLocally(mealType: MealType, likeDelta: Int, dislikeDelta: Int) {
        let current = menu.reaction(for: mealType)
        let updated = Reaction(
            likeCount: max(0, current.likeCount + likeDelta),
            dislikeCount: max(0, current.dislikeCount + dislikeDelta)
        )
        var reactions = menu.reactions
        reactions[mealType.rawValue] = updated
        self.menu = CafeteriaMenu(
            breakfastMenu: menu.breakfastMenu,
            lunchMenu: menu.lunchMenu,
            dinnerMenu: menu.dinnerMenu,
            reactions: reactions
        )
    }
    /// 작업 취소
    //    func stopObserving() {
    //        fetchTask?.cancel()
    //        fetchTask = nil
    //    }
    
    /// 식당 또는 날짜 변경 시 다시 가져오기
    //    func restartObserving() {
    //        startObserving()
    //    }
    
    //    func handleAction(mealType: MealType, actionType: MealActionType) {
    //        // REST API에서는 좋아요/싫어요 기능 미지원
    //    }
    
    /// 투표 상태 확인
    //    func hasVoted(mealType: MealType, actionType: MealActionType) -> Bool {
    //        false
    //    }
}
