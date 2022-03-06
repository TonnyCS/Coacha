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

        self.sessionStore.signInAnonymously { result in
            switch result {
                case .success(_):
                    self.appRouter.setCurrentPage(to: .main)
                case .failure(let error):
                    self.dismissLoading()
                    self.showError(error: error)
            }
        }
    }
}
