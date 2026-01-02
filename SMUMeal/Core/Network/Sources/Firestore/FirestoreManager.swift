//
//  FirestoreManager.swift
//  Network
//
//  Created by 김진혁 on 12/31/25.
//

import FirebaseFirestore
import Domain

public class FirestoreManager {
    public static let shared = FirestoreManager()
    private let db = Firestore.firestore()
    
    private init() {}
    
    @discardableResult
    public func save<T: EntityRepresentable>(_ data: T) async throws -> T {
        guard let dict = data.asDictionary else { throw FirestoreError.encodingFailed }
        let ref = db
            .collection(data.entityName.rawValue)
            .document(data.documentID)

        try await ref.setData(dict)
        return data
    }
    
    @discardableResult
    public func create<T: EntityRepresentable>(_ data: T) async throws -> T {
        try await save(data)
    }
    
    @discardableResult
    public func update<T: EntityRepresentable>(_ data: T) async throws -> T {
        try await save(data)
    }
    
    /// 특정 필드만 부분 업데이트를 진행하는 메서드입니다.
    /// - Parameters:
    ///     - collection: 컬렉션 타입
    ///     - documentId: 변경하고자 하는 documentId
    ///     - asDictionary: 변경하려는 딕셔너리 데이터
    public func updateFields(
        collection: CollectionType,
        documentId: String,
        asDictionary: [String: Any]
    ) async throws {
        let asDictionary = asDictionary
        
        try await db
            .collection(collection.rawValue)
            .document(documentId)
            .updateData(asDictionary)
    }
    
    /// 컬렉션의 데이터를 가져옵니다.
    /// - id: documentID
    /// - type: 컬렉션 타입
    public func get<T: Decodable>(
        _ id: String,
        from type: CollectionType
    ) async throws -> T {
        let snapshot = try await db.collection(type.rawValue).document(id).getDocument()
        guard let data = try? snapshot.data(as: T.self) else {
            throw FirestoreError.fetchFailed(
                underlying: NSError(
                    domain: "", code: -1,
                    userInfo: [NSLocalizedDescriptionKey: "문서가 존재하지 않습니다."]
                )
            )
        }
        return data
    }
    
    /// 컬렉션의 모든 데이터를 가져옵니다.
    /// 파이어베이스 색인으로 정렬합니다.
    /// - Parameters:
    /// - id: userID
    /// - type: 컬렉션 타입
    /// - key: 컬렉션 안의 문서의 대한 조건절
    /// - orderKey: 어느 기준으로 정렬
    /// - descending: 정렬 방향
    @discardableResult
    public func fetchAll<T: Decodable>(
        _ id: String,
        from type: CollectionType,
        where key: String,
        orderBy orderKey: String? = nil,
        descending: Bool = true
    ) async throws -> [T] {
        var query: Query = db.collection(type.rawValue).whereField(key, isEqualTo: id)
        if let orderKey { query = query.order(by: orderKey, descending: descending) }
        let snap = try await query.getDocuments()
        return snap.documents.compactMap { try? $0.data(as: T.self) }
    }
}
