//
//  SplashViewModel.swift
//  Coacha
//
//  Created by Anthony Šimek on 04.03.2022.
//

import SwiftUI

final class SplashViewModel: CommonErrorHandlingViewModel {
    @ObservedObject var appRouter: AppRouter = AppRouter()
    @ObservedObject var sessionStore: SessionStore = SessionStore()
    
    func onAppear() {
        self.checkForUser()
    }
    
    func login() {
        self.showLoading()
        
        self.sessionStore.signInAnonymously { _, error in
            self.dismissLoading()
            
            if let error = error {
                self.showError(error: error)
            } else {
                self.appRouter.setCurrentPage(to: .main)
            }
        }
    }
    
    private func checkForUser() {
        self.sessionStore.checkForAlreadySignedInUser { error in
            if let error = error {
                debugPrint("SPLASH_VM/CHECK_FOR_ALREADY_SIGNED_IN_USER: Error: \(error.localizedDescription)")
            } else {
                self.appRouter.setCurrentPage(to: .main)
            }
        }
    }
}
