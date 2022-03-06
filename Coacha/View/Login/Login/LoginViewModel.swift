//
//  LoginViewModel.swift
//  Coacha
//
//  Created by Anthony Šimek on 06.03.2022.
//

import SwiftUI

final class LoginViewModel: CommonErrorHandlingViewModel {
    @ObservedObject var appRouter: AppRouter = AppRouter()
    @ObservedObject var sessionStore: SessionStore = SessionStore()
    
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
}
