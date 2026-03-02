//
//  FetchMenuRequest.swift
//  Network
//
//  Created by 김진혁 on 2/14/26.
//

import Foundation
import Domain

public struct FetchMenuRequest: APIRequest {
    public typealias Response = CafeteriaMenu

    public let cafeteriaType: String
    public let date: String

    public var path: String {
        "/menus/\(cafeteriaType)/\(date)"
    }

    public var method: HTTPMethod { .get }

    public init(cafeteriaType: String, date: String) {
        self.cafeteriaType = cafeteriaType
        self.date = date
    }
}
