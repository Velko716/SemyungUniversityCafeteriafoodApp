//
//  Encodable+.swift
//  Utility
//
//  Created by 김진혁 on 1/1/26.
//

import Foundation

extension Encodable {
    /// Encodable → [String: Any] 변환 (간단 버전: JSONEncoder)
    public var asDictionary: [String: Any]? {
        guard let object = try? JSONEncoder().encode(self),
              let dictionary = try? JSONSerialization.jsonObject(with: object, options: [])
                as? [String: Any] else {
            return nil
        }
        
        return dictionary
    }
}
