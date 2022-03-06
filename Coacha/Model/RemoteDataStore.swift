//
//  DataStore.swift
//  Coacha
//
//  Created by Anthony Šimek on 04.03.2022.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class RemoteDataStore: ObservableObject {
    private var db = Firestore.firestore()
    
    @Published private(set) var allSportActivity = [SportActivity]()
    
    // MARK: - GET
    func getAllSportActivity() {
        guard let userID = Auth.auth().currentUser?.uid else {
            debugPrint("DATA_STORE/getAllSportActivity: Error: No userID")
            return
        }
        
        self.db
            .collection(C.dataStore.collection.profile)
            .document(userID)
            .collection(C.dataStore.collection.sportActivity)
            .order(by: C.dataStore.key.sportActivity.date)
            .addSnapshotListener { (querySnapshot, error) in
                if let error = error {
                    debugPrint("DATA_STORE/getAllSportActivity: Error \(error.localizedDescription)")
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    debugPrint("DATA_STORE/getAllSportActivity: Error: NO DOCUMENTS FOUND")
                    return
                }
                
                self.allSportActivity = documents.compactMap({ (queryDocumentSnapshot) -> RemoteSportActivity? in
                    return try? queryDocumentSnapshot.data(as: RemoteSportActivity.self)
                })
            }
    }
    
    // MARK: - PUT
    func putSportActivity(sportActivity: RemoteSportActivity, completion: @escaping (Result<RemoteSportActivity, Error>) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else {
            debugPrint("DATA_STORE/putSportActivity: Error: No userID")
            return
        }

        do {
            let _ = try self.db
                .collection(C.dataStore.collection.profile)
                .document(userID)
                .collection(C.dataStore.collection.sportActivity)
                .document(sportActivity.id.uuidString)
                .setData(from: sportActivity)
            
            debugPrint("DATA_STORE/putSportActivity: Success: \(sportActivity.id.uuidString), userID: \(userID)")
            completion(.success(sportActivity))
            
        } catch {
            debugPrint("DATA_STORE/putSportActivity: Error: \(error.localizedDescription)")
            completion(.failure(error))
        }
    }
    
    // MARK: - REMOVE
    func deleteSportActivity(id: UUID, completion: @escaping (Result<UUID, Error>) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else {
            debugPrint("DATA_STORE/deleteSportActivity: Error: No userID")
            return
        }
        
        self.db
            .collection(C.dataStore.collection.profile)
            .document(userID)
            .collection(C.dataStore.collection.sportActivity)
            .document(id.uuidString)
            .delete() { error in
                if let error = error {
                    debugPrint("DATA_STORE/putSportActivity: Error: \(error.localizedDescription)")
                    completion(.failure(error))
                } else {
                    debugPrint("DATA_STORE/putSportActivity: Success")
                    completion(.success(id))
                }
            }
    }
}
