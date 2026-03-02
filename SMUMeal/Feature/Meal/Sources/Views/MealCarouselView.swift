//
//  MealCarouselView.swift
//  Meal
//
//  Created by 김진혁 on 1/1/26.
//

import SwiftUI
import Repository
import UIComponents
import Utility
import Setting
import Network
import Domain

public struct MealCarouselView<SettingDestination: View>: View {
    @State private var viewModel: MealCarouselViewModel
    @State private var isCalendarPresented: Bool = false
    @State private var tempSelectedDate: Date = Date()
    @State private var holidays: [Date] = []
    @State private var dragOffset: CGFloat = 0
    @State private var toastWorkItem: DispatchWorkItem?
    private let holidayService: HolidayServiceProtocol
    private let settingDestination: () -> SettingDestination

    public init(
        repository: MealRepositoryProtocol,
        holidayService: HolidayServiceProtocol = HolidayService(),
        @ViewBuilder settingDestination: @escaping () -> SettingDestination
    ) {
        _viewModel = State(
            initialValue: MealCarouselViewModel(repository: repository)
        )
        self.holidayService = holidayService
        self.settingDestination = settingDestination
    }
    
    public var body: some View {
        NavigationStack {
            ZStack {
                Color.navy01.ignoresSafeArea()
                
                VStack {
                    DateHeaderView(dateString: viewModel.choiceDate.displayString) {
                        self.isCalendarPresented = true
                    }

                    MealCardView(
                        dateString: viewModel.choiceDate.displayString,
                        breakfastMenu: viewModel.menu.breakfastMenu,
                        lunchMenu: viewModel.menu.lunchMenu,
                        dinnerMenu: viewModel.menu.dinnerMenu,
                        reactions: viewModel.menu.reactions,
                        isLoading: viewModel.isLoading,
                        highlightedMealType: viewModel.choiceDate.isToday ? MealType.current() : nil,
                        contentOffset: dragOffset,
                        selectedDate: Binding(
                            get: { viewModel.choiceDate },
                            set: { viewModel.choiceDate = $0 }
                        ),
                        onBreakfastLike: { Task { await viewModel.likeUp(mealType: .breakfast) } },
                        onBreakfastDislike: { Task { await viewModel.dislikeUp(mealType: .breakfast) } },
                        onLunchLike: { Task { await viewModel.likeUp(mealType: .lunch) } },
                        onLunchDislike: { Task { await viewModel.dislikeUp(mealType: .lunch) } },
                        onDinnerLike: { Task { await viewModel.likeUp(mealType: .dinner) } },
                        onDinnerDislike: { Task { await viewModel.dislikeUp(mealType: .dinner) } }
                    )
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                dragOffset = value.translation.width
                            }
                            .onEnded { value in
                                let threshold: CGFloat = 50
                                let screenWidth = UIScreen.main.bounds.width
                                if value.translation.width < -threshold {
                                    // 왼쪽 스와이프 → 현재 카드 왼쪽으로 퇴장
                                    withAnimation(.easeOut(duration: 0.2)) {
                                        dragOffset = -screenWidth
                                    } completion: {
                                        // 날짜 변경 후, 새 카드를 오른쪽에서 진입
                                        viewModel.choiceDate = viewModel.choiceDate.adding(days: 1)
                                        dragOffset = screenWidth
                                        withAnimation(.easeOut(duration: 0.25)) {
                                            dragOffset = 0
                                        }
                                    }
                                } else if value.translation.width > threshold {
                                    // 오른쪽 스와이프 → 현재 카드 오른쪽으로 퇴장
                                    withAnimation(.easeOut(duration: 0.2)) {
                                        dragOffset = screenWidth
                                    } completion: {
                                        // 날짜 변경 후, 새 카드를 왼쪽에서 진입
                                        viewModel.choiceDate = viewModel.choiceDate.adding(days: -1)
                                        dragOffset = -screenWidth
                                        withAnimation(.easeOut(duration: 0.25)) {
                                            dragOffset = 0
                                        }
                                    }
                                } else {
                                    withAnimation(.easeOut(duration: 0.2)) {
                                        dragOffset = 0
                                    }
                                }
                            }
                    )
                }
                .padding([.horizontal, .bottom], 16)
                .clipped()
                .overlay {
                    if isCalendarPresented {
                        ZStack {
                            // 회색 반투명 배경
                            Color.black.opacity(0.4)
                                .ignoresSafeArea()
                                .onTapGesture {
                                    isCalendarPresented = false
                                }
                            // Alert 스타일 뷰
                            VStack(spacing: 16) {
                                ZStack {
                                    Text("날짜 선택")
                                        .font(.pretendard(size: 18, weight: .semibold))
                                        .foregroundStyle(Color.white01)

                                    HStack {
                                        Spacer()
                                        XmarkButton { isCalendarPresented = false }
                                            .frame(width: 19, height: 19)
                                    }
                                }

                                CustomCalendarView(
                                    selectedDate: $tempSelectedDate,
                                    holidays: holidays,
                                    onMonthChange: { newMonth in
                                        Task { await fetchHolidays(for: newMonth) }
                                    }
                                )

                                Button("확인") {
                                    viewModel.choiceDate = tempSelectedDate
                                    isCalendarPresented = false
                                }
                                .font(.pretendard(size: 16, weight: .medium))
                                .foregroundStyle(Color.white01)
                                .padding(.vertical, 12)
                                .frame(maxWidth: .infinity)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.blue01)
                                )
                            }
                            .padding(20)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.navy01)
                            )
                            .padding(.horizontal, 32)
                            .onAppear {
                                tempSelectedDate = viewModel.choiceDate
                                Task { await fetchHolidays() }
                            }
                        }
                    }
                }
            }
            .overlay(alignment: .bottom) {
                if let message = viewModel.toastMessage {
                    ToastView(text: message)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 16)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .animation(.easeInOut(duration: 0.25), value: viewModel.toastMessage)
            .onChange(of: viewModel.toastMessage) {
                toastWorkItem?.cancel()
                guard viewModel.toastMessage != nil else { return }
                let workItem = DispatchWorkItem {
                    withAnimation {
                        viewModel.toastMessage = nil
                    }
                }
                toastWorkItem = workItem
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: workItem)
            }
            .task {
                //self.viewModel.isLoading = true
                await viewModel.fetchMeal()
            }
            .onChange(of: viewModel.choiceDate) {
                Task { await viewModel.fetchMeal() }
            }
            .onChange(of: viewModel.toolBarType) {
                Task { await viewModel.fetchMeal() }
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
                    settingDestination()
                }
            }
        }
    }

    // MARK: - 공휴일 가져오기
    private func fetchHolidays(for date: Date? = nil) async {
        let targetDate = date ?? tempSelectedDate
        let calendar = Calendar.current
        let year = calendar.component(.year, from: targetDate)
        let month = calendar.component(.month, from: targetDate)

        do {
            let fetchedHolidays = try await holidayService.fetchHolidays(year: year, month: month)
            await MainActor.run {
                holidays = fetchedHolidays.filter { $0.isHoliday }.map { $0.date }
            }
        } catch {
            print("🗓️ Failed to fetch holidays: \(error)")
            if let holidayError = error as? HolidayServiceError {
                print("🗓️ Holiday error description: \(holidayError.errorDescription ?? "unknown")")
            }
        }
    }
}

// MARK: - Preview (외부 모듈 의존성 없이 UI만 테스트)
//#Preview("MealCarouselView UI") {
//    MealCarouselView(repository: MockMealRepository())
//}

