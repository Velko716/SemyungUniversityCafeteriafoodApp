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
            CarouselView(
                dateString: viewModel.choiceDate.fullDateString,
                breakfastMenu: menu.breakfastMenu,
                lunchMenu: menu.lunchMenu,
                dinnerMenu: menu.dinnerMenu,
                breakfastLikeCount: menu.breakfastLikeCount,
                lunchLikeCount: menu.lunchLikeCount,
                dinnerLikeCount: menu.dinnerLikeCount,
                breakfastDislikeCount: menu.breakfastDislikeCount,
                lunchDislikeCount: menu.lunchDislikeCount,
                dinnerDislikeCount: menu.dinnerDislikeCount
            )
            .task {
                do {
                    self.menu = try await viewModel.loadMeal(targetDate: viewModel.choiceDate)
                } catch {
                    print("error")
                }
            }
            .toolbar {
//                MealCenterToolbar(
//                    cafeteriaType: viewModel.toolBarType,
//                    displayName: { $0.displayName }) {
//                    switch viewModel.toolBarType {
//                    case .studentCafeteria:
//                        // FIXME: - 뷰 모델 로직으로 교체
//                        viewModel.toolBarType = .studentCafeteria
//                    case .selfServiceCafeteria:
//                        // FIXME: - 뷰 모델 로직으로 교체
//                        viewModel.toolBarType = .selfServiceCafeteria
//                    case .yejiDormitoryCafeteria:
//                        // FIXME: - 뷰 모델 로직으로 교체
//                        viewModel.toolBarType = .yejiDormitoryCafeteria
//                    }
//                }
                MealCenterToolbar(
                    cafeteriaType: viewModel.toolBarType,
                    displayName: { $0.displayName }
                ) { selectedType in
                    viewModel.toolBarType = selectedType
                }
            }
            .onChange(of: viewModel.toolBarType) {
                Task {
                    do {
                        self.menu = try await viewModel.loadMeal(targetDate: viewModel.choiceDate)
                    } catch {
                        print("error")
                    }
                }
            }
        }
    }
}

//#Preview {
//    MealCarouselView(repository: MockMealRepository())
//}
