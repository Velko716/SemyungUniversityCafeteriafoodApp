//
//  Date+.swift
//  Utility
//
//  Created by 김진혁 on 1/1/26.
//

import Foundation

extension Date {
    public var fullDateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-DD"
        
        return formatter.string(from: self)
    }
}
