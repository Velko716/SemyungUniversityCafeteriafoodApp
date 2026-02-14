//
//  SMUMealApp.swift
//  App
//
//  Created by 김진혁 on 2/13/26.
//

/*
2. 파이어베이스 에러 타입 정리하기
3. 코드 정리하기
6. 위에꺼 다하고는 스켈레톤 애니메이션 적용, 셋팅뷰쪽?, 달력 변경되면 식단도 같이 변경될 수 있게, Tuist 코드 정리, 토큰 중복 방지(계속 CloudFuntion을 요청함), 알림 부분에 Key도 같이 있어야 등록될 수 있게(암호화하기 위해서)
 Meal, Settings 모듈 분리
 */

import SwiftUI
import Meal
import Repository
import Settings

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
