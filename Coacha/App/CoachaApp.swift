//
//  CoachaApp.swift
//  Coacha
//
//  Created by Anthony Šimek on 04.03.2022.
//

import SwiftUI

@main
struct CoachaApp: App {
    @StateObject var appRouter: AppRouter = AppRouter()
    
    @StateObject var appModel: CoachaAppModel = CoachaAppModel()
    
    @StateObject var sportActivityListViewModel: SportActivityListViewModel = SportActivityListViewModel()
    @StateObject var splashViewModel: SplashViewModel = SplashViewModel()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                switch self.appRouter.currentPage {
                    case .main:
                        SportActivityListView(viewModel: self.sportActivityListViewModel)
                            .onAppear { self.appModel.dataStore.getAllSportActivity() }
                            .environmentObject(self.appModel.dataStore)
                            .environmentObject(self.appModel.mapHelper)
                    default:
                        SplashView(viewModel: self.splashViewModel)
                            .environmentObject(self.appRouter)
                            .environmentObject(self.appModel.sessionStore)
                }
            }
            .transition(.opacity)
            .animation(.easeInOut, value: self.appRouter.currentPage)
        }
    }
}
