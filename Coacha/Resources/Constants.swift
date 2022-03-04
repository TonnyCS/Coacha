//
//  Constants.swift
//  Coacha
//
//  Created by Anthony Šimek on 04.03.2022.
//

import Foundation

typealias C = Constants

enum Constants {
    enum dataStore {
        enum collection {
            static let profile: String = "profile"
            static let sportActivity: String = "sportActivity"
        }
        
        enum key {
            enum sportActivity {
                static let id: String = "id"
                static let name: String = "name"
                static let place: String = "place"
                static let duration: String = "duration"
                static let date: String = "date"
            }
        }
    }
}
