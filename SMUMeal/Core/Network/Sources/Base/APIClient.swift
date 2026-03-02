//
//  APIClient.swift
//  Network
//
//  Created by 김진혁 on 2/14/26.
//

import Foundation
import Common
import Utility

public final class APIClient {
    public static let shared = APIClient()

    private let baseURL: String
    private let apiKey: String
    private let session: URLSession

    public init(
        baseURL: String = Bundle.main.apiBaseURL,
        apiKey: String = Bundle.main.apiKey,
        session: URLSession = .shared
    ) {
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.session = session
    }

    public func send<R: APIRequest>(_ request: R) async throws -> R.Response {
        guard let url = URL(string: "\(baseURL)\(request.path)") else {
            throw CafeteriaAPIError.invalidURL
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.setValue(apiKey, forHTTPHeaderField: "x-api-key")

        // Add custom headers
        request.headers?.forEach { key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }

        // Add body if exists
        if let body = request.body {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(AnyEncodable(body))
        }

        let (data, response) = try await session.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw CafeteriaAPIError.invalidResponse
        }

        switch httpResponse.statusCode {
        case 200...299:
            return try JSONDecoder().decode(R.Response.self, from: data)
        case 404:
            throw CafeteriaAPIError.menuNotFound
        default:
            let message = String(data: data, encoding: .utf8) ?? "Unknown error"
            throw CafeteriaAPIError.serverError(message)
        }
    }
}

// MARK: - AnyEncodable wrapper
private struct AnyEncodable: Encodable {
    private let encode: (Encoder) throws -> Void

    init(_ wrapped: Encodable) {
        self.encode = wrapped.encode
    }

    func encode(to encoder: Encoder) throws {
        try encode(encoder)
    }
}
