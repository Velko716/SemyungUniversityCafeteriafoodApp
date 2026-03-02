//
//  Bundle+.swift
//  Utility
//
//  Created by 김진혁 on 2/14/26.
//

import Foundation

extension Bundle {
    public var apiBaseURL: String {
        infoDictionary?["API_BASE_URL"] as? String ?? ""
    }

    public var apiKey: String {
        infoDictionary?["API_KEY"] as? String ?? ""
    }

    public var holidayApiBaseURL: String {
        infoDictionary?["HOLIDAY_API_BASE_URL"] as? String ?? ""
    }

    public var holidayApiKey: String {
        infoDictionary?["HOLIDAY_API_KEY"] as? String ?? ""
    }
}
