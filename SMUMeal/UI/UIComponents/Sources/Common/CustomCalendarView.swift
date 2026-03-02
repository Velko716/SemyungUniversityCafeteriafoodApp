//
//  CustomCalendarView.swift
//  Components
//
//  Created by 김진혁 on 2/14/26.
//

import SwiftUI
import DesignSystem

public struct CustomCalendarView: View {
    @Binding var selectedDate: Date
    @State private var displayedMonth: Date

    private let calendar = Calendar.current
    private let weekdays = ["일", "월", "화", "수", "목", "금", "토"]

    // 공휴일 날짜 Set (빠른 조회용)
    private let holidayDates: Set<String>

    // 월 변경 콜백
    private let onMonthChange: ((Date) -> Void)?

    public init(
        selectedDate: Binding<Date>,
        holidays: [Date] = [],
        onMonthChange: ((Date) -> Void)? = nil
    ) {
        self._selectedDate = selectedDate
        self._displayedMonth = State(initialValue: selectedDate.wrappedValue)
        self.onMonthChange = onMonthChange

        // Date를 "yyyyMMdd" 문자열로 변환하여 Set에 저장
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        self.holidayDates = Set(holidays.map { formatter.string(from: $0) })
    }

    public var body: some View {
        VStack(spacing: 16) {
            // MARK: - 월/년 헤더
            headerView

            // MARK: - 요일 헤더
            weekdayHeader

            // MARK: - 날짜 그리드
            daysGrid
        }
        .frame(width: 320, height: 350)
    }

    // MARK: - 헤더 (월/년 + 네비게이션)
    private var headerView: some View {
        HStack {
            Button {
                let newMonth = calendar.date(byAdding: .month, value: -1, to: displayedMonth) ?? displayedMonth
                displayedMonth = newMonth
                onMonthChange?(newMonth)
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundStyle(Color.blue01)
            }

            Spacer()

            Text(monthYearString)
                .font(.pretendard(size: 17, weight: .semibold))
                .foregroundStyle(Color.white01)

            Spacer()

            Button {
                let newMonth = calendar.date(byAdding: .month, value: 1, to: displayedMonth) ?? displayedMonth
                displayedMonth = newMonth
                onMonthChange?(newMonth)
            } label: {
                Image(systemName: "chevron.right")
                    .foregroundStyle(Color.blue01)
            }
        }
        .padding(.horizontal, 16)
    }

    // MARK: - 요일 헤더
    private var weekdayHeader: some View {
        HStack(spacing: 0) {
            ForEach(0..<7, id: \.self) { index in
                Text(weekdays[index])
                    .font(.pretendard(size: 13, weight: .medium))
                    .foregroundStyle(weekdayColor(for: index))
                    .frame(maxWidth: .infinity)
            }
        }
    }

    // MARK: - 날짜 그리드
    private var daysGrid: some View {
        let days = generateDays()

        return LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 7), spacing: 8) {
            ForEach(days, id: \.self) { date in
                if let date = date {
                    dayCell(for: date)
                } else {
                    Text("")
                        .frame(height: 40)
                }
            }
        }
    }

    // MARK: - 날짜 셀
    private func dayCell(for date: Date) -> some View {
        let isSelected = calendar.isDate(date, inSameDayAs: selectedDate)
        let isToday = calendar.isDateInToday(date)
        let weekday = calendar.component(.weekday, from: date)
        let holiday = isHoliday(date)

        return Button {
            selectedDate = date
        } label: {
            Text("\(calendar.component(.day, from: date))")
                .font(.pretendard(size: 17, weight: isSelected ? .semibold : .regular))
                .foregroundStyle(dayColor(weekday: weekday, isSelected: isSelected, isHoliday: holiday))
                .frame(width: 40, height: 40)
                .background(
                    Circle()
                        .fill(isSelected ? Color.blue01 : Color.clear)
                )
                .overlay(
                    Circle()
                        .stroke(isToday && !isSelected ? Color.blue01 : Color.clear, lineWidth: 1)
                )
        }
    }

    // MARK: - 요일 색상
    private func weekdayColor(for index: Int) -> Color {
        switch index {
        case 0: return .red01  // 일요일
        case 6: return .blue01 // 토요일
        default: return .gray01
        }
    }

    // MARK: - 날짜 색상
    private func dayColor(weekday: Int, isSelected: Bool, isHoliday: Bool) -> Color {
        if isSelected {
            return .white01
        }
        // 공휴일이면 빨간색
        if isHoliday {
            return .red01
        }
        switch weekday {
        case 1: return .red01  // 일요일
        case 7: return .blue01 // 토요일
        default: return .white01
        }
    }

    // MARK: - 공휴일 여부 확인
    private func isHoliday(_ date: Date) -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let dateString = formatter.string(from: date)
        return holidayDates.contains(dateString)
    }

    // MARK: - 월/년 문자열
    private var monthYearString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 M월"
        return formatter.string(from: displayedMonth)
    }

    // MARK: - 해당 월의 날짜 배열 생성
    private func generateDays() -> [Date?] {
        var days: [Date?] = []

        guard let monthInterval = calendar.dateInterval(of: .month, for: displayedMonth),
              let firstWeekday = calendar.dateComponents([.weekday], from: monthInterval.start).weekday else {
            return days
        }

        // 첫 주 빈 칸 추가
        for _ in 1..<firstWeekday {
            days.append(nil)
        }

        // 해당 월의 날짜 추가
        var currentDate = monthInterval.start
        while currentDate < monthInterval.end {
            days.append(currentDate)
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate) ?? currentDate
        }

        return days
    }
}

#Preview {
    CustomCalendarView(selectedDate: .constant(Date()))
        .padding()
}
