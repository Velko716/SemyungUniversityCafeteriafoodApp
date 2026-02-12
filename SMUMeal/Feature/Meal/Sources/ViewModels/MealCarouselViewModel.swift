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
import Components

@Observable
internal final class MealCarouselViewModel {
    private let repository: MealRepositoryProtocol
    private var observeTask: Task<Void, Never>?

    internal var menu: CafeteriaMenu = .init(
        breakfastMenu: "",
        lunchMenu: "",
        dinnerMenu: "",
        breakfastLikeCount: 0,
        lunchLikeCount: 0,
        dinnerLikeCount: 0,
        breakfastDislikeCount: 0,
        lunchDislikeCount: 0,
        dinnerDislikeCount: 0
    )
    internal var choiceDate: Date = Date()
    internal var toolBarType: CafeteriaType = .studentCafeteria {
        didSet {
            UserDefaults.standard.set(toolBarType.rawValue, forKey: "lastCafeteriaType")
        }
    }

    internal init(repository: MealRepositoryProtocol) {
        self.repository = repository
        if let saved = UserDefaults.standard.string(forKey: "lastCafeteriaType"),
           let type = CafeteriaType(rawValue: saved) {
            self.toolBarType = type
        }
    }

    /// 실시간 구독 시작
    func startObserving() {
        stopObserving()
        observeTask = Task {
            do {
                for try await cafeteriaMenu in repository.observeMeal(
                    cafeteriaType: toolBarType,
                    targetDate: choiceDate.fullDateString
                ) {
                    await MainActor.run {
                        self.menu = cafeteriaMenu
                    }
                }
            } catch {
                print("Observe error: \(error)")
            }
        }
    }

    /// 구독 중지
    func stopObserving() {
        observeTask?.cancel()
        observeTask = nil
    }

    /// 식당 또는 날짜 변경 시 재구독
    func restartObserving() {
        startObserving()
    }

    func handleAction(mealType: MealType, actionType: MealActionType) {
        let mealTime: MealTimeType = switch mealType {
        case .breakfast: .breakfast
        case .lunch: .lunch
        case .dinner: .dinner
        }

        let action: CountActionType = switch actionType {
        case .like: .like
        case .dislike: .dislike
        }

        let voteKey = makeVoteKey(mealTime: mealTime, action: action)
        let hasVoted = UserDefaults.standard.bool(forKey: voteKey)
        let increment = hasVoted ? -1 : 1

        Task {
            do {
                try await repository.updateCount(
                    cafeteriaType: toolBarType,
                    targetDate: choiceDate.fullDateString,
                    mealTime: mealTime,
                    action: action,
                    increment: increment
                )
                // 성공 시 투표 상태 토글
                UserDefaults.standard.set(!hasVoted, forKey: voteKey)
            } catch {
                print("updateCount error: \(error)")
            }
        }
    }

    /// 투표 상태 확인
    func hasVoted(mealType: MealType, actionType: MealActionType) -> Bool {
        let mealTime: MealTimeType = switch mealType {
        case .breakfast: .breakfast
        case .lunch: .lunch
        case .dinner: .dinner
        }

        let action: CountActionType = switch actionType {
        case .like: .like
        case .dislike: .dislike
        }

        let voteKey = makeVoteKey(mealTime: mealTime, action: action)
        return UserDefaults.standard.bool(forKey: voteKey)
    }

    private func makeVoteKey(mealTime: MealTimeType, action: CountActionType) -> String {
        "\(toolBarType.rawValue)_\(choiceDate.fullDateString)_\(mealTime.rawValue)_\(action.rawValue)"
    }
}
