//
//  SMUMealApp.swift
//  App
//
//  Created by 김진혁 on 2/13/26.
//

/*
3. 코드 정리하기
4. CI/CD 정도
6. 전체 코드 정리(Tuist 포함), 앱 폰트나 컬러수정
 "notification extension을 제거해줘. 서버에서 이 부분을 달려고 해", 서버측 "알림 할때 \N이 보이는데 이걸 ,으로 표시될 수 있도록 수정해줘."
 <확인 필요>
1. CI/CD
 도메인 + 문제 + 해결 + 결과
 */

import SwiftUI
import Meal
import Repository
import Setting

@main
struct SMUMealApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self)
    var delegate

    var body: some Scene {
        WindowGroup {
            MealCarouselView(
                repository: MealRepository()
            ) {
                SettingView()
            }
        }
    }
}

//struct ContentView: View {
//    @State private var adHeight: CGFloat = 50
//
//    // 실제 광고 단위 ID
//    private let adUnitID = "ca-app-pub-1780050413977337/7873364664"
//
//    var body: some View {
//        ZStack(alignment: .bottom) {
//            MealCarouselView(
//                repository: MealRepository()
//            ) {
//                SettingView()
//            }
//            .padding(.bottom, adHeight)
//        }
//        .ignoresSafeArea(.keyboard)
//    }
//}
