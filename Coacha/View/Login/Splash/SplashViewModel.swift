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
        self.sessionStore.checkForAlreadySignedInUser { result in
            switch result {
                case .success(_):
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
                        self.appRouter.setCurrentPage(to: .main)
                    }
                case .failure(_):
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
                        self.appRouter.setCurrentPage(to: .login)
                    }
            }
        }
    }
}
