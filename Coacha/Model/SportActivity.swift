//
//  SportActivity.swift
//  Coacha
//
//  Created by Anthony Šimek on 04.03.2022.
//

import Foundation

protocol SportActivity {
    var id: UUID { get set }
    var name: String { get set }
    var place: String { get set }
    var duration: DateDuration { get set }
    var date: Date { get set }
    var isLocal: Bool { get set }
}

struct RemoteSportActivity: SportActivity, Identifiable, Codable {
    var id: UUID
    var name: String
    var place: String
    var duration: DateDuration
    var date: Date
    var isLocal: Bool = false
    
    init(id: UUID = UUID(), name: String, place: String, duration: DateDuration, date: Date = Date()) {
        self.id = id
        self.name = name
        self.place = place
        self.duration = duration
        self.date = date
    }
}

struct LocalSportActivity: SportActivity, Identifiable, Codable {
    var id: UUID
    var name: String
    var place: String
    var duration: DateDuration
    var date: Date
    var isLocal: Bool = true
    
    init(id: UUID = UUID(), name: String, place: String, duration: DateDuration, date: Date = Date()) {
        self.id = id
        self.name = name
        self.place = place
        self.duration = duration
        self.date = date
    }
}

