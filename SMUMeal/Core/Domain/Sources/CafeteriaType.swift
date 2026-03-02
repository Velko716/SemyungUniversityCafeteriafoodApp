//
//  CafeteriaType.swift
//  Domain
//
//  Created by 김진혁 on 1/2/26.
//

public enum CafeteriaType: String, CaseIterable {
    case studentCafeteria
    case selfServiceCafeteria
    case yejiDormitoryCafeteria
    
    public var displayName: String {
        switch self {
        case .studentCafeteria:
            "학생회관_학생식당"
        case .selfServiceCafeteria:
            "학생회관_자율식당"
        case .yejiDormitoryCafeteria:
            "예지학사식당"
        }
    }
    
    public var collectionType: String {
        switch self {
        case .studentCafeteria:
            "student_cafeteria"
        case .selfServiceCafeteria:
            "self_service_cafeteria"
        case .yejiDormitoryCafeteria:
            "yeji_cafeteria"
        }
    }
}
