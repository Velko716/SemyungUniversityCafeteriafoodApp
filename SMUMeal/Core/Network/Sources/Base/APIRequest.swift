//
//  APIRequest.swift
//  Network
//
//  Created by 김진혁 on 2/14/26.
//

import Foundation

public protocol APIRequest {
    associatedtype Response: Decodable

    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var body: Encodable? { get }
}

// MARK: - Default implementations
public extension APIRequest {
    var headers: [String: String]? { nil }
    var body: Encodable? { nil }
}
