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

    public init(repository: MealRepositoryProtocol) {
        _viewModel = State(
            initialValue: MealCarouselViewModel(repository: repository)
        )
    }
    
    public var body: some View {
        NavigationStack {
            ZStack {
                Color.navy01.ignoresSafeArea()
                
                VStack {
                    MealCardView(
                        dateString: viewModel.choiceDate.displayString,
                        breakfastMenu: viewModel.menu.breakfastMenu,
                        lunchMenu: viewModel.menu.lunchMenu,
                        dinnerMenu: viewModel.menu.dinnerMenu,
                        breakfastLikeCount: viewModel.menu.breakfastLikeCount,
                        lunchLikeCount: viewModel.menu.lunchLikeCount,
                        dinnerLikeCount: viewModel.menu.dinnerLikeCount,
                        breakfastDislikeCount: viewModel.menu.breakfastDislikeCount,
                        lunchDislikeCount: viewModel.menu.lunchDislikeCount,
                        dinnerDislikeCount: viewModel.menu.dinnerDislikeCount,
                        selectedDate: Binding(
                            get: { viewModel.choiceDate },
                            set: { viewModel.choiceDate = $0 }
                        ),
                        onAction: { mealType, actionType in
                            viewModel.handleAction(mealType: mealType, actionType: actionType)
                        }
                    )
                    .onAppear {
                      print("dateString: \(viewModel.choiceDate.displayString)")
                      print("dateString: \(viewModel.menu.breakfastMenu)")
                    }
                }
                .padding([.horizontal, .bottom], 16)
            }
            .task {
                viewModel.startObserving()
            }
            .onDisappear {
                viewModel.stopObserving()
            }
            // MARK: - 식당 변경 시
            .onChange(of: viewModel.toolBarType) {
                viewModel.restartObserving()
            }
            // MARK: - 날짜 변경 시
            .onChange(of: viewModel.choiceDate) {
                viewModel.restartObserving()
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

