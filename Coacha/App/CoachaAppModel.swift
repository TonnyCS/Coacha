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
    @ObservedObject var localDataStore: LocalDataStore
    @ObservedObject var mapHelper: MapHelper
    @ObservedObject var userDefaultsHelper: UserDefaultsHelper
    
    init() {
        FirebaseApp.configure()
        
        self.sessionStore = SessionStore()
        self.remoteDataStore = RemoteDataStore()
        self.localDataStore = LocalDataStore()
        self.mapHelper = MapHelper()
        self.userDefaultsHelper = UserDefaultsHelper()
        
        self.checkForFirstTimeStartup()
    }
    
    private func checkForFirstTimeStartup() {
        if !userDefaultsHelper.hasRunBefore {
            self.sessionStore.signOut { result in
                switch result {
                    case .success(_):
                        debugPrint("APP_MODEL/checkForFirstTimeStartup: Success")
                    case .failure(let error):
                        debugPrint("APP_MODEL/checkForFirstTimeStartup: Error: \(error.localizedDescription)")
                        
                }
                
                self.userDefaultsHelper.hasRunBefore = true
            }
        }
    }
    
    func onSportActivityListVIewAppear() {
        self.remoteDataStore.getAllSportActivity()
        self.localDataStore.performFetchOfSportActivity()
    }
}
