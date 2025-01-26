//
//  AppDelegate.swift
//  WebCrawlingProject
//
//  Created by 김진혁 on 3/4/24.
//
import Foundation
import UIKit
import CoreData
import FirebaseCore
import FirebaseFirestore
import FirebaseAnalytics

// Notifications
import UserNotifications

// BGTask
import BackgroundTasks

// FirebaseNotifications
import FirebaseInAppMessagingSwift
import FirebaseMessaging
import GoogleMobileAds    // 광고 추가




@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let operationQueue = OperationQueue()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        GADMobileAds.sharedInstance().start(completionHandler: nil)    // 광고 추가
        
        
        
       
        
        
//            // 레지스터 등록
//        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.example.dateRefresh", using: nil) { task in
//            print("start")
//            print("Task identifier: \(task.identifier)")
//            handleAppRefresh(task: task as! BGAppRefreshTask)
//            print("end")
//        }
//        
//        
//        
//        
//        // 스케줄러 등록시간
//        func scheduleAppRefresh() {
//           let request = BGAppRefreshTaskRequest(identifier: "com.example.dateRefresh")
//           // Fetch no earlier than 15 minutes from now.
//           request.earliestBeginDate = Date(timeIntervalSinceNow: 15 * 60)
//                
//           do {
//              try BGTaskScheduler.shared.submit(request)
//               print("성공")
//           } catch {
//              print("Could not schedule app refresh: \(error)")
//           }
//        }
//        
//        
//        
//        
//        // 작업
//        func handleAppRefresh(task: BGAppRefreshTask) {
//           // Schedule a new refresh task.
//           scheduleAppRefresh()
//
//
//           // Create an operation that performs the main part of the background task.
//           let operation = RefreshAppContentsOperation()
//           
//           // Provide the background task with an expiration handler that cancels the operation.
//           task.expirationHandler = {
//              operation.cancel()
//           }
//
//
//           // Inform the system that the background task is complete
//           // when the operation completes.
//           operation.completionBlock = {
//              task.setTaskCompleted(success: !operation.isCancelled)
//           }
//
//
//           // Start the operation.
//           operationQueue.addOperation(operation)
//         }
//        
//        
        
        
        // 아침메뉴 가져오기
        FirebaseApp.configure()
        let db = Firestore.firestore()
        
        
        
        
        
        
        // 알림 권한 요청
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                print("사용자가 알림 권한을 허용했습니다.")
            } else {
                print("사용자가 알림 권한을 거부했습니다.")
            }
        }
        
        
        // 원격알림 등록: 푸시든 로컬이든 알람 허용해야 그 이후에 가능
        UNUserNotificationCenter.current().delegate = self
        
        
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
        )
        
    
        // fcm 메세지 사용
        application.registerForRemoteNotifications()
        
        
        
        // FirebaseMessaging
        Messaging.messaging().delegate = self
  
        
       
        
        
        
        // 로컬 알림
        
        UNUserNotificationCenter.current().delegate = self
        
    
        
        SchedulingService.shared.registerBackgroundTasks()
        
        return true
    }
    

    
    
    
    
  
    
    

    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
        
        
        
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        
        let container = NSPersistentContainer(name: "WebCrawlingProject")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                
                
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    
    // MARK: - Core Data Saving support
    
//    func saveContext () {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                
//                
//                
//                
//                
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }
    
    
    
    // 포그라운드 식단 알림 설정
    //    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    //            // 앱이 foreground에 있을 때 알림을 표시하기 위한 설정
    //            completionHandler([.alert, .sound])
    //        }
    
}


extension AppDelegate: UNUserNotificationCenterDelegate {
    // 앱이 실행 중일 때 알림을 처리하기 위한 메서드
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
    }
    
    // 사용자가 알림을 탭하여 앱을 열 때 실행되는 메서드
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // 알림을 처리하는 추가 작업이 필요한 경우 이곳에 작성
        completionHandler()
    }
}




//extension AppDelegate: UNUserNotificationCenterDelegate {
//    
//}

// Firebase
extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        
        let token = String(describing: fcmToken)
        //print("Firebase registration token: \(token)")
        
        let dataDict: [String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: dataDict
        )
    }
    
}



