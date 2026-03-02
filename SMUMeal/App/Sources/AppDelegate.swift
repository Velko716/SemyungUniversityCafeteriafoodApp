//
//  AppDelegate.swift
//  App
//
//  Created by 김진혁 on 2/13/26.
//

import UIKit
import FirebaseCore
import FirebaseMessaging
import UserNotifications
import Network
import DesignSystem
// import GoogleMobileAds

final class AppDelegate: NSObject,
                         UIApplicationDelegate,
                         UNUserNotificationCenterDelegate,
                         MessagingDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {

        // 폰트 등록
        DesignSystem.registerFonts()


        FirebaseApp.configure()

        UNUserNotificationCenter.current().delegate = self

        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .badge, .sound]
        ) { granted, error in }

        application.registerForRemoteNotifications()

        Messaging.messaging().delegate = self

        return true
    }

    // FCM 토큰 받는 부분
    func messaging(_ messaging: Messaging,
                   didReceiveRegistrationToken fcmToken: String?) {
        print("🔥 FCM Token:", fcmToken ?? "")
        if let token = fcmToken {
            sendTokenToServer(token: token)
        }
    }

    func sendTokenToServer(token: String) {
        let storedToken = UserDefaults.standard.string(forKey: "fcmToken")

        // 같은 토큰이면 스킵
        if storedToken == token {
            print("Token already registered, skipping")
            return
        }

        Task {
            do {
                let request = RegisterTokenRequest(token: token)
                let response = try await APIClient.shared.send(request)

                // 성공 시 저장
                UserDefaults.standard.set(token, forKey: "fcmToken")
                print("Token registered:", response.success)
            } catch {
                print("Token send error:", error)
            }
        }
    }
    
    

    // Foreground 수신 처리
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification
    ) async -> UNNotificationPresentationOptions {
        let current = await UIApplication.shared.applicationIconBadgeNumber
        try? await center.setBadgeCount(current + 1)
        return [.banner, .sound, .badge]
    }

    // 앱 활성화 시 뱃지 초기화
    func applicationDidBecomeActive(_ application: UIApplication) {
        UNUserNotificationCenter.current().setBadgeCount(0)
    }
    
    func application(
      _ application: UIApplication,
      didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        print("APNs device token received")
    }
}
