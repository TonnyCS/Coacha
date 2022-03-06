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
    @ObservedObject var remoteDataStore: RemoteDataStore
    @ObservedObject var mapHelper: MapHelper
    @ObservedObject var userDefaultsHelper: UserDefaultsHelper
    
    init() {
        FirebaseApp.configure()
        
        self.sessionStore = SessionStore()
        self.remoteDataStore = RemoteDataStore()
        self.mapHelper = MapHelper()
        self.userDefaultsHelper = UserDefaultsHelper()
        
        self.checkForFirstTimeStartup()
    }
    
    private func checkForFirstTimeStartup() {
        if userDefaultsHelper.hasRunBefore {
            self.sessionStore.signOut { error in
                if let error = error {
                    debugPrint("APP_MODEL/checkForFirstTimeStartup: Error: \(error.localizedDescription)")
                }
                
                self.userDefaultsHelper.hasRunBefore = true
            }
        }
    }
    
    func onSportActivityListVIewAppear() {
        self.remoteDataStore.getAllSportActivity()
    }
}
