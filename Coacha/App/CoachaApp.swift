//
//  CoachaApp.swift
//  Coacha
//
//  Created by Anthony Šimek on 04.03.2022.
//

import SwiftUI

@main
struct CoachaApp: App {
    @StateObject var appModel: CoachaAppModel = CoachaAppModel()
    @StateObject var appRouter: AppRouter = AppRouter()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                switch self.appRouter.currentPage {
                    case .main:
                        ContentView()
                    default:
                        SplashView(viewModel: SplashViewModel())
                            .environmentObject(self.appRouter)
                }
            }
            .transition(.opacity)
            .animation(.easeInOut, value: self.appRouter.currentPage)
        }
    }
}
