//
//  DislikeRequest.swift
//  Network
//
//  Created by 김진혁 on 2/14/26.
//

import Foundation

public struct DislikeRequest: APIRequest {
    public typealias Response = MessageResponse

    public let cafeteriaType: String
    public let date: String
    public let meal: String

    public var path: String {
        "/menus/\(cafeteriaType)/\(date)/dislike"
    }

    public var method: HTTPMethod { .post }

    public var body: Encodable? {
        ["meal": meal]
    }

    public init(cafeteriaType: String, date: String, meal: String) {
        self.cafeteriaType = cafeteriaType
        self.date = date
        self.meal = meal
    }
}
