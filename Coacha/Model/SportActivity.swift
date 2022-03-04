//
//  SportActivity.swift
//  Coacha
//
//  Created by Anthony Šimek on 04.03.2022.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct SportActivity: Identifiable, Codable {
    var id: UUID
    var name: String
    var place: String
    var duration: Int
    var date: Date
    var isLocal: Bool //TODO better - Not saving, map, mainly firestore
    
    init(data: [String: Any]) {
        self.id = UUID(uuidString: data[C.dataStore.key.sportActivity.id] as? String ?? "") ?? UUID()
        self.name = data[C.dataStore.key.sportActivity.name] as? String ?? "NOT_FOUND"
        self.place = data[C.dataStore.key.sportActivity.place] as? String ?? "NOT_FOUND"
        self.duration = data[C.dataStore.key.sportActivity.duration] as? Int ?? 0
        self.date = (data[C.dataStore.key.sportActivity.date] as? Timestamp)?.dateValue() ?? Date()
        self.isLocal = data[C.dataStore.key.sportActivity.isLocal] as? Bool ?? false
    }
    
    init(id: UUID = UUID(), name: String, place: String, duration: Int, date: Date = Date(), isLocal: Bool) {
        self.id = id
        self.name = name
        self.place = place
        self.duration = duration
        self.date = date
        self.isLocal = isLocal
    }
}
