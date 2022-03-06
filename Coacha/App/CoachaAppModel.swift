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
    @ObservedObject var mapHelper: MapHelper
    
    init() {
        FirebaseApp.configure()
        
        self.sessionStore = SessionStore()
        self.dataStore = DataStore()
        self.mapHelper = MapHelper()
        
        self.checkForFirstTimeStartup()
    }
    
    private func checkForFirstTimeStartup() {
        if !UD.shared.hasRunBefore {
            self.sessionStore.signOut { error in
                if let error = error {
                    debugPrint("APP_MODEL/checkForFirstTimeStartup: Error: \(error.localizedDescription)")
                }
                
                UD.shared.hasRunBefore = true
            }
        }
    }
}
