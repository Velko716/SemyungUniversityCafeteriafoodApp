//
//  EntityRepresentable.swift
//  Network
//
//  Created by 김진혁 on 1/1/26.
//

public protocol EntityRepresentable {
    var entityName: CollectionType { get }
    var documentID: String { get }
    var asDictionary: [String: Any]? { get }
}
