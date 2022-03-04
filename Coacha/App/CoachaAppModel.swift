//
//  CoachaAppModel.swift
//  Coacha
//
//  Created by Anthony Šimek on 04.03.2022.
//

import SwiftUI
import Firebase

final class CoachaAppModel: ObservableObject {
    @ObservedObject var sessionStore: SessionStore
    @ObservedObject var dataStore: DataStore
    
    init() {
        FirebaseApp.configure()
        
        self.sessionStore = SessionStore()
        self.dataStore = DataStore()
    }
}
