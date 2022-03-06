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
    var duration: DateDuration
    var date: Date
    var isLocal: Bool //TODO better - Not saving, map, mainly firestore
    
    init(id: UUID = UUID(), name: String, place: String, duration: DateDuration, date: Date = Date(), isLocal: Bool) {
        self.id = id
        self.name = name
        self.place = place
        self.duration = duration
        self.date = date
        self.isLocal = isLocal
    }
}
