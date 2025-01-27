//
//  SceneDelegate.swift
//  WebCrawlingProject
//
//  Created by 김진혁 on 3/4/24.
//

import UIKit
import FirebaseFirestore
import BackgroundTasks

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    let db = Firestore.firestore()


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        
        // ? AppDelegate
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("Notification permission granted")
            }
        }
        
        
        // add NavigationController
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        let mainViewController = ViewController()
        let navigationController = UINavigationController(rootViewController: mainViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
    }
    
    
    
    

    func sceneDidDisconnect(_ scene: UIScene) {
       
        
        
        
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
       
        
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
        
        
        
    }
    
    
    
    

    func sceneWillEnterForeground(_ scene: UIScene) {
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        //self.notification()
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
        // 백그라운드 작업 예약
        SchedulingService.shared.scheduleAppRefresh()
        
        //(UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        // self.notification()
    }
    
    func notification() {
        
        var breakfastMenus: String?
        var lunchMenus: String?
        var dinnerMenus: String?
        
        getBreakfastMenu { (breakfastMenu, error) in
            guard let breakfastMenu = breakfastMenu  else {
                print("Error getting breakfast menu: \(error?.localizedDescription ?? "Unknown error")")
                
                return
            }
            breakfastMenus = breakfastMenu
        }
            
            
        getLunchMenu { (lunchMenu, error) in
            guard let lunchMenu = lunchMenu else {
                print("Error getting lunch menu: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            lunchMenus = lunchMenu
            
        }
                
        getDinnerMenu { (dinnerMenu, error) in
            guard let dinnerMenu = dinnerMenu else {
                print("Error getting dinner menu: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            dinnerMenus = dinnerMenu
        }
        
        
                    
        // "아직 식단이 등록되지 않았습니다."일 경우 알림을 보내지 않음
        if breakfastMenus == "아직 식단이 등록되지 않았습니다." || breakfastMenus == "" { return }
            
            
        // "아직 식단이 등록되지 않았습니다."일 경우 알림을 보내지 않음
        if lunchMenus == "아직 식단이 등록되지 않았습니다." || lunchMenus == "" { return }
            
            
        // "아직 식단이 등록되지 않았습니다."일 경우 알림을 보내지 않음
        if dinnerMenus == "아직 식단이 등록되지 않았습니다." || dinnerMenus == "" { return     }
    
        
            
        

        // 현재 날짜 데이터 포맷
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        
        // FIXME: - 임시 테스트
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let formatter2Date = formatter2.string(from: Date())
        
        let current_date_string = formatter.string(from: Date())
        //let current_date_string2 = formatter2.string(from: Date())
        
        
        let content = UNMutableNotificationContent()
        content.title = "세명대학교 조식"
        content.body = breakfastMenus ?? "아직 식단이 등록되지 않았습니다."
        content.sound = UNNotificationSound.default
        
        
        
        let content2 = UNMutableNotificationContent()
        content2.title = "세명대학교 중식"
        content2.body = lunchMenus ?? "아직 식단이 등록되지 않았습니다."
        content2.sound = UNNotificationSound.default
        
        
        
        let content3 = UNMutableNotificationContent()
        content3.title = "세명대학교 석식"
        content3.body = dinnerMenus ?? "아직 식단이 등록되지 않았습니다."
        content3.sound = UNNotificationSound.default
        
        
        
        // 첫 번째 알림: 08:30
        var dateComponents1 = DateComponents()
        dateComponents1.hour = 08
        dateComponents1.minute = 30
        let trigger1 = UNCalendarNotificationTrigger(dateMatching: dateComponents1, repeats: true)
        let request1 = UNNotificationRequest(identifier: "uniqueIdentifier1", content: content, trigger: trigger1)
        
        
        
        // 두 번째 알림: 11:00
        var dateComponents2 = DateComponents()
        dateComponents2.hour = 11
        dateComponents2.minute = 00
        let trigger2 = UNCalendarNotificationTrigger(dateMatching: dateComponents2, repeats: true)
        let request2 = UNNotificationRequest(identifier: "uniqueIdentifier2", content: content2, trigger: trigger2)
        
        
        // repeats가 기존에는 false였음.
        
        // 세 번째 알림: 17:30
        var dateComponents3 = DateComponents()
        dateComponents3.hour = 17
        dateComponents3.minute = 30
        let trigger3 = UNCalendarNotificationTrigger(dateMatching: dateComponents3, repeats: true)
        let request3 = UNNotificationRequest(identifier: "uniqueIdentifier3", content: content3, trigger: trigger3)
        
        
        
        
        let notificationCenter = UNUserNotificationCenter.current()
        
        
        notificationCenter.add(request1) { (error) in
            if let error = error {
                print("Error adding notification request1: \(error)")
            }
        }
        notificationCenter.add(request2) { (error) in
            if let error = error {
                print("Error adding notification request2: \(error)")
            }
        }
        notificationCenter.add(request3) { (error) in
            if let error = error {
                print("Error adding notification request3: \(error)")
            }
        }
    }
    // 아침메뉴 가져오기
    func getBreakfastMenu(completion: @escaping (String?, Error?) -> Void) {
        
        print("getBreakfastMenu")
        
        let currentDate = UserDefaults.standard.value(forKey: "currentDate")
        
        // 현재 날짜 데이터 포맷
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        let current_date_string = formatter.string(from: Date())
        
        let docRef = db.collection("Menu").document(currentDate as! String)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let breakfastMenu = document.data()?["아침메뉴"] as? String {
                    let breakfastMenu = breakfastMenu.replacingOccurrences(of: "\\n", with: "\n")
                    
                    completion(breakfastMenu, nil)
                    
                    
                } else {
                    completion(nil, nil)
                }
            } else {
                completion(nil, error)
            }
        }
    }
    
    // 점심메뉴 가져오기
    func getLunchMenu(completion: @escaping (String?, Error?) -> Void) {
        
        let currentDate = UserDefaults.standard.value(forKey: "currentDate")
        
        // 현재 날짜 데이터 포맷
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        let current_date_string = formatter.string(from: Date())
        
        let docRef = db.collection("Menu").document(currentDate as! String)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let lunchMenu = document.data()?["점심메뉴"] as? String {
                    let lunchMenu = lunchMenu.replacingOccurrences(of: "\\n", with: "\n")
                    
                    completion(lunchMenu, nil)
                } else {
                    completion(nil, nil)
                }
            } else {
                completion(nil, error)
            }
        }
    }
    
    // 저녁메뉴 가져오기
    func getDinnerMenu(completion: @escaping (String?, Error?) -> Void) {
        
        let currentDate = UserDefaults.standard.value(forKey: "currentDate")
        
        // 현재 날짜 데이터 포맷
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        let current_date_string = formatter.string(from: Date())
        
        let docRef = db.collection("Menu").document(currentDate as! String)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let dinnerMenu = document.data()?["저녁메뉴"] as? String {
                    let dinnerMenu = dinnerMenu.replacingOccurrences(of: "\\n", with: "\n")
                    completion(dinnerMenu, nil)
                } else {
                    completion(nil, nil)
                }
            } else {
                completion(nil, error)
            }
        }
    }
    

}








