//
//  String+.swift
//  Utility
//
//  Created by 김진혁 on 1/22/26.
//

extension String {
    /// 문자열 내의 리터럴 개행("\\n")을 실제 개행("\n")으로 변환
    public func replacingLiteralNewlines() -> String {
        self.replacingOccurrences(of: "\\n", with: "\n")
    }
}
