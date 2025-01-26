//
//  BackgroundTask.swift
//  WebCrawlingProject
//
//  Created by 김진혁 on 1/24/25.
//

import UIKit
import BackgroundTasks
import Firebase

// 25/1/23 추가
class SchedulingService {
    static let shared = SchedulingService()
    let db = Firestore.firestore()
        
    func registerBackgroundTasks() {
        let isRegistered = BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.example.dateRefresh", using: nil) { task in
            print("Background task is executing: \(task.identifier)")
            self.handleAppRefresh(task: task as! BGAppRefreshTask)
        }
        print("Is the background task registered? \(isRegistered)")
    }
    
    func scheduleAppRefresh() {
        let request = BGAppRefreshTaskRequest(identifier: "com.example.dateRefresh")
        
        // 한국 시간 기준 00:10으로 설정
        let timeZone = TimeZone(identifier: "Asia/Seoul")!
        if let nextRefreshTime = Date().settingTime(hour: 0, minute: 10, timeZone: timeZone) {
            request.earliestBeginDate = nextRefreshTime
            print("earliestBeginDate 설정: \(nextRefreshTime)") // 로그 출력
        } else {
            print("earliestBeginDate 설정 실패")
        }
        
        //request.earliestBeginDate = Date(timeIntervalSinceNow: 60 * 2) // 2분 마다의 작업 (테스트 용)
        
        
        //  e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateExpirationForTaskWithIdentifier:@"com.example.dateRefresh"]
        do {
            try BGTaskScheduler.shared.submit(request)
            print("breakPoint")
            // breakPoint
        } catch {
            print("Could not schedule app refresh: \(error)")
        }
    }
    
    private func handleAppRefresh(task: BGAppRefreshTask) {
        // <!-- Your background logic here -->
        // <!-- LocalNotificationService.sharedInstance.initScheduleNotifications() -->
        print("handleAppRefresh")
        
        // background 알림 등록
        notification()
        
        print("handleAppRefreshFinsh")
        
        task.setTaskCompleted(success: true)
        
        print("handleAppRefreshComplete")
        
        scheduleAppRefresh()
    }
    
    
    
    func notification() {
        
        getBreakfastMenu { (breakfastMenu, error) in
            guard let breakfastMenu = breakfastMenu  else {
                print("Error getting breakfast menu: \(error?.localizedDescription ?? "Unknown error")")
                
                return
            }
            
            
            
            // 점심메뉴 가져오기
            self.getLunchMenu { (lunchMenu, error) in
                guard let lunchMenu = lunchMenu else {
                    print("Error getting lunch menu: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                // 저녁메뉴 가져오기
                self.getDinnerMenu { (dinnerMenu, error) in
                    guard let dinnerMenu = dinnerMenu else {
                        print("Error getting dinner menu: \(error?.localizedDescription ?? "Unknown error")")
                        return
                    }
                    
                    
                    // "아직 식단이 등록되지 않았습니다."일 경우 알림을 보내지 않음
                    if breakfastMenu == "아직 식단이 등록되지 않았습니다." {
                        print("Breakfast menu not available. Skipping notification.")
                        return
                    }
                    
                    // "아직 식단이 등록되지 않았습니다."일 경우 알림을 보내지 않음
                    if lunchMenu == "아직 식단이 등록되지 않았습니다." {
                        print("Breakfast menu not available. Skipping notification.")
                        return
                    }
                    
                    // "아직 식단이 등록되지 않았습니다."일 경우 알림을 보내지 않음
                    if dinnerMenu == "아직 식단이 등록되지 않았습니다." {
                        print("Breakfast menu not available. Skipping notification.")
                        return
                    }
                    
                    
                    
                    
                    
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
                    content.body = breakfastMenu
                    content.sound = UNNotificationSound.default
                    
                    
                    
                    let content2 = UNMutableNotificationContent()
                    content2.title = "세명대학교 중식"
                    content2.body = lunchMenu
                    content2.sound = UNNotificationSound.default
                    
                    
                    
                    let content3 = UNMutableNotificationContent()
                    content3.title = "세명대학교 석식"
                    content3.body = dinnerMenu
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
            }
        }
    }
    
    
    
    // 아침메뉴 가져오기
    func getBreakfastMenu(completion: @escaping (String?, Error?) -> Void) {
        
        print("getBreakfastMenu")
        
        
        // 현재 날짜 데이터 포맷
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        let current_date_string = formatter.string(from: Date())
        
        let docRef = db.collection("Menu").document(current_date_string)
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
        
        
        
        // 현재 날짜 데이터 포맷
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        let current_date_string = formatter.string(from: Date())
        
        let docRef = db.collection("Menu").document(current_date_string)
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
        
        
        
        // 현재 날짜 데이터 포맷
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        let current_date_string = formatter.string(from: Date())
        
        let docRef = db.collection("Menu").document(current_date_string)
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
