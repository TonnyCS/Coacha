//
//  SplashViewModel.swift
//  Coacha
//
//  Created by Anthony Šimek on 04.03.2022.
//

import SwiftUI

final class SplashViewModel: ObservableObject {
    @ObservedObject var appRouter: AppRouter = AppRouter()
    @ObservedObject var sessionStore: SessionStore = SessionStore()
    
    func onAppear() {
        self.checkForUser()
    }
    
    private func checkForUser() {
        self.sessionStore.checkForAlreadySignedInUser { error in
            if let error = error {
                debugPrint("SPLASH_VM/CHECK_FOR_ALREADY_SIGNED_IN_USER: Error: \(error.localizedDescription)")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
                    self.appRouter.setCurrentPage(to: .login)
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
                    self.appRouter.setCurrentPage(to: .main)
                }
            }
        }
    }
}
