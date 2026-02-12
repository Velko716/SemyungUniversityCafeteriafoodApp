//
//  FirestoreManager.swift
//  Network
//
//  Created by 김진혁 on 12/31/25.
//

import Foundation
import Domain
import Common


struct FirestoreCafeteriaMenuDTO: Decodable {
    let name: String
    let fields: Fields
    
    struct Fields: Decodable {
        let breakfastMenu: StringField
        let lunchMenu: StringField
        let dinnerMenu: StringField
        
        let breakfastLikeCount: IntField
        let lunchLikeCount: IntField
        let dinnerLikeCount: IntField
        
        let breakfastDislikeCount: IntField
        let lunchDislikeCount: IntField
        let dinnerDislikeCount: IntField
        
        enum CodingKeys: String, CodingKey {
            case breakfastMenu = "breakfast_menu"
            case lunchMenu = "lunch_menu"
            case dinnerMenu = "dinner_menu"
            
            case breakfastLikeCount = "breakfast_like_count"
            case lunchLikeCount = "lunch_like_count"
            case dinnerLikeCount = "dinner_like_count"
            
            case breakfastDislikeCount = "breakfast_dislike_count"
            case lunchDislikeCount = "lunch_dislike_count"
            case dinnerDislikeCount = "dinner_dislike_count"
        }
    }
    
    struct StringField: Decodable {
        let stringValue: String
    }
    
    struct IntField: Decodable {
        let integerValue: String
    }
}


extension FirestoreCafeteriaMenuDTO {
    
    func toDomain() -> CafeteriaMenu {
        CafeteriaMenu(
            breakfastMenu: fields.breakfastMenu.stringValue,
            lunchMenu: fields.lunchMenu.stringValue,
            dinnerMenu: fields.dinnerMenu.stringValue,
            
            breakfastLikeCount: Int(fields.breakfastLikeCount.integerValue) ?? 0,
            lunchLikeCount: Int(fields.lunchLikeCount.integerValue) ?? 0,
            dinnerLikeCount: Int(fields.dinnerLikeCount.integerValue) ?? 0,
            
            breakfastDislikeCount: Int(fields.breakfastDislikeCount.integerValue) ?? 0,
            lunchDislikeCount: Int(fields.lunchDislikeCount.integerValue) ?? 0,
            dinnerDislikeCount: Int(fields.dinnerDislikeCount.integerValue) ?? 0
        )
    }
}

public struct FirestoreService {
    
    private let projectId = "webcrawlingproject-6a4d1"
    private let apiKey = "AIzaSyB5IXnCVbE0Zec3w_U0b9gi5uZDoXDx-8w"
    
    public init() {}
    
    public func fetchMenu(documentId: String) async throws -> CafeteriaMenu {
        
        let urlString = """
        https://firestore.googleapis.com/v1/projects/\(projectId)/databases/(default)/documents/student_cafeteria/\(documentId)
        """
        // ?key=\(apiKey)
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let httpResponse = response as? HTTPURLResponse {
            print("Status Code:", httpResponse.statusCode)
        }

        print(String(data: data, encoding: .utf8) ?? "")
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let dto = try JSONDecoder().decode(FirestoreCafeteriaMenuDTO.self, from: data)
        
        return dto.toDomain()
    }
}






public struct AnonymousAuthResponse: Decodable {
    let idToken: String
    let refreshToken: String
    let localId: String
    let expiresIn: String
}

public struct TestAuth {
    public init() {}
    
    public func signInAnonymously() async throws -> AnonymousAuthResponse {
        
        let url = URL(string:
                        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyB5IXnCVbE0Zec3w_U0b9gi5uZDoXDx-8w"
        )!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = """
    {
      "returnSecureToken": true
    }
    """.data(using: .utf8)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return try JSONDecoder().decode(AnonymousAuthResponse.self, from: data)
    }
}


// MARK: - API

// MARK: - API Response
public struct MenuResponse: Codable {
    let success: Bool
    let data: CafeteriaMenu?
    let message: String?
}

// MARK: - API Service
public class CafeteriaAPI {
    static let shared = CafeteriaAPI()
    private let baseURL = "https://us-central1-webcrawlingproject-6a4d1.cloudfunctions.net/api"
    
    public init() {}
    
    /// 특정 날짜의 메뉴를 가져옵니다
    /// - Parameter date: 날짜 문자열 (예: "2025.02.12")
    public func fetchMenu(for date: String) async throws -> CafeteriaMenu {
        guard let url = URL(string: "\(baseURL)/menus/\(date)") else {
            throw CafeteriaAPIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw CafeteriaAPIError.invalidResponse
        }
        
        let decoded = try JSONDecoder().decode(MenuResponse.self, from: data)
        
        switch httpResponse.statusCode {
        case 200:
            guard let menu = decoded.data else {
                throw CafeteriaAPIError.noData
            }
            return menu
        case 404:
            throw CafeteriaAPIError.menuNotFound
        default:
            throw CafeteriaAPIError.serverError(decoded.message ?? "Unknown error")
        }
    }
}
