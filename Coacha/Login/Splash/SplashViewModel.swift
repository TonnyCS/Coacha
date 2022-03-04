//
//  SplashViewModel.swift
//  Coacha
//
//  Created by Anthony Šimek on 04.03.2022.
//

import SwiftUI

final class SplashViewModel: ObservableObject {
    @ObservedObject var appRouter: AppRouter = AppRouter()
    
    func login() {
        self.appRouter.setCurrentPage(to: .main)
    }
}
