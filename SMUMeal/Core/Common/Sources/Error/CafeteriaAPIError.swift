//
//  CafeteriaAPIError.swift
//  Common
//
//  Created by 김진혁 on 2/12/26.
//

import Foundation

// MARK: - Error
public enum CafeteriaAPIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case noData
    case menuNotFound
    case serverError(String)
    
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "잘못된 URL입니다"
        case .invalidResponse:
            return "서버 응답이 올바르지 않습니다"
        case .noData:
            return "데이터가 없습니다"
        case .menuNotFound:
            return "해당 날짜의 메뉴가 없습니다"
        case .serverError(let message):
            return message
        }
    }
}
