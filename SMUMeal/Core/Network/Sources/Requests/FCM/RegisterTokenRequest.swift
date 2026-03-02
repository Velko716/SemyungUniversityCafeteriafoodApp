//
//  RegisterTokenRequest.swift
//  Network
//
//  Created by 김진혁 on 2/14/26.
//

import Foundation

public struct RegisterTokenRequest: APIRequest {
    public typealias Response = SuccessResponse

    public let token: String

    public var path: String { "/register-token" }

    public var method: HTTPMethod { .post }

    public var body: Encodable? {
        ["token": token]
    }

    public init(token: String) {
        self.token = token
    }
}
