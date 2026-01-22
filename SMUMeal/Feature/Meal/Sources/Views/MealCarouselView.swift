//
//  MealCarouselView.swift
//  Meal
//
//  Created by 김진혁 on 1/1/26.
//

import SwiftUI
import Repository
import Components
import Network
import Utility
import Settings

public struct MealCarouselView: View {
    @State private var viewModel: MealCarouselViewModel
    @State private var menu: CafeteriaMenu = .init(
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
    
    public init(repository: MealRepositoryProtocol) {
        _viewModel = State(
            initialValue: MealCarouselViewModel(repository: repository)
        )
    }
    
    public var body: some View {
        NavigationStack {
            ZStack {
                Color.blue.ignoresSafeArea()
                
                VStack {
                    MealCardView(
                        dateString: viewModel.choiceDate.displayString,
                        breakfastMenu: menu.breakfastMenu,
                        lunchMenu: menu.lunchMenu,
                        dinnerMenu: menu.dinnerMenu,
                        breakfastLikeCount: menu.breakfastLikeCount,
                        lunchLikeCount: menu.lunchLikeCount,
                        dinnerLikeCount: menu.dinnerLikeCount,
                        breakfastDislikeCount: menu.breakfastDislikeCount,
                        lunchDislikeCount: menu.lunchDislikeCount,
                        dinnerDislikeCount: menu.dinnerDislikeCount,
                        selectedDate: Binding(
                            get: { viewModel.choiceDate },
                            set: { viewModel.choiceDate = $0 }
                        )
                    )
                }
                .padding([.horizontal, .bottom], 16)
            }
            .task {
                do {
                    self.menu = try await viewModel.loadMeal(targetDate: viewModel.choiceDate)
                } catch {
                    print("error")
                }
            }
            // MARK: - 식당 변경 시
            .onChange(of: viewModel.toolBarType) {
                Task {
                    do {
                        self.menu = try await viewModel.loadMeal(targetDate: viewModel.choiceDate)
                    } catch {
                        print("error")
                    }
                }
            }
            // MARK: - 날짜 변경 시
            .onChange(of: viewModel.choiceDate) {
                Task {
                    do {
                        self.menu = try await viewModel.loadMeal(targetDate: viewModel.choiceDate)
                        print("menu: \(menu)")
                    } catch {
                        print("error")
                    }
                }
            }
            // MARK: - 툴 바
            .toolbar {
                MealCenterToolbar(
                    cafeteriaType: viewModel.toolBarType,
                    displayName: { $0.displayName }
                ) { selectedType in
                    viewModel.toolBarType = selectedType
                }
                MealTrailingToolbar {
                    SettingView()
                }
            }
        }
    }
}

// MARK: - Preview (외부 모듈 의존성 없이 UI만 테스트)
//#Preview("MealCarouselView UI") {
//    MealCarouselView(repository: MockMealRepository())
//}

