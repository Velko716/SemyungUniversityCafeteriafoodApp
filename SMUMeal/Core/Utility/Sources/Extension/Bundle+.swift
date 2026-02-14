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
}
