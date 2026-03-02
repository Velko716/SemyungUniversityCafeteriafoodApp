//
//  ToastPosition.swift
//  Utility
//
//  Created by 김진혁 on 2/16/26.
//

import SwiftUI

public enum ToastPosition {
    case top, center, bottom
    public var alignment: Alignment {
        switch self {
        case .top:
            return .top
        case .center:
            return .center
        case .bottom:
            return .bottom
        }
    }
}
