//
//  HolidayService.swift
//  Network
//
//  Created by 김진혁 on 2/15/26.
//

import Foundation
import Domain
import Utility

public protocol HolidayServiceProtocol {
    func fetchHolidays(year: Int, month: Int) async throws -> [Holiday]
}

public final class HolidayService: HolidayServiceProtocol {
    private let baseURL: String
    private let apiKey: String
    private let session: URLSession

    public init(baseURL: String = Bundle.main.holidayApiBaseURL, apiKey: String = Bundle.main.holidayApiKey, session: URLSession = .shared) {
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.session = session
    }

    public func fetchHolidays(year: Int, month: Int) async throws -> [Holiday] {
        let monthString = String(format: "%02d", month)

        // API 키 확인 (디버그용)
        print("🗓️ API Key loaded: \(apiKey.isEmpty ? "EMPTY!" : "OK (\(apiKey.prefix(20))...)")")

        // API 키가 이미 URL 인코딩되어 있으므로 직접 URL 문자열 구성
        let urlString = "\(baseURL)?serviceKey=\(apiKey)&solYear=\(year)&solMonth=\(monthString)&numOfRows=50"

        guard let url = URL(string: urlString) else {
            print("🗓️ Invalid URL: \(urlString)")
            throw HolidayServiceError.invalidURL
        }

        print("🗓️ Holiday API URL: \(url.absoluteString)")

        do {
            let (data, response) = try await session.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse else {
                print("🗓️ Response is not HTTPURLResponse")
                throw HolidayServiceError.serverError
            }

            print("🗓️ Holiday API Status: \(httpResponse.statusCode)")

            // 응답 데이터 확인 (디버그용)
            if let responseString = String(data: data, encoding: .utf8) {
                print("🗓️ Holiday API Response: \(responseString.prefix(1500))")
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                print("🗓️ HTTP Error: \(httpResponse.statusCode)")
                throw HolidayServiceError.serverError
            }

            let parser = HolidayXMLParser(data: data)
            let holidays = parser.parse()
            print("🗓️ Parsed \(holidays.count) holidays")
            return holidays
        } catch let error as HolidayServiceError {
            throw error
        } catch {
            print("🗓️ Network error: \(error.localizedDescription)")
            throw HolidayServiceError.networkError(error)
        }
    }
}

// MARK: - XML Parser
final class HolidayXMLParser: NSObject, XMLParserDelegate {
    private let data: Data
    private var holidays: [Holiday] = []

    private var currentElement = ""
    private var currentLocdate = ""
    private var currentDateName = ""
    private var currentIsHoliday = ""

    init(data: Data) {
        self.data = data
    }

    func parse() -> [Holiday] {
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
        return holidays
    }

    // MARK: - XMLParserDelegate
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName

        if elementName == "item" {
            currentLocdate = ""
            currentDateName = ""
            currentIsHoliday = ""
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let trimmed = string.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        switch currentElement {
        case "locdate":
            currentLocdate += trimmed
        case "dateName":
            currentDateName += trimmed
        case "isHoliday":
            currentIsHoliday += trimmed
        default:
            break
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            if let date = parseDate(currentLocdate) {
                let holiday = Holiday(
                    date: date,
                    name: currentDateName,
                    isHoliday: currentIsHoliday == "Y"
                )
                holidays.append(holiday)
            }
        }
        currentElement = ""
    }

    private func parseDate(_ dateString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.date(from: dateString)
    }
}

// MARK: - Error
public enum HolidayServiceError: Error, LocalizedError {
    case invalidURL
    case serverError
    case parsingError
    case networkError(Error)

    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .serverError:
            return "Server error"
        case .parsingError:
            return "Parsing error"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        }
    }
}
