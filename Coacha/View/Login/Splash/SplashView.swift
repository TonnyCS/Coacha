//
//  SplashView.swift
//  Coacha
//
//  Created by Anthony Šimek on 04.03.2022.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var appRouter: AppRouter
    @EnvironmentObject var sessionStore: SessionStore
    @Namespace private var animation
    
    @StateObject var viewModel: SplashViewModel
    
    var body: some View {
        VStack {
            switch self.appRouter.currentPage {
                case .splash:
                    SplashView_Content(animation: self.animation)
                case .login:
                    LoginView(animation: self.animation, viewModel: LoginViewModel())
                default:
                    LoadingView(color: R.color.perm.white)
                        .zStackBackground(R.color.cinnabar)
            }
        }
        .zStackBackground(R.color.cinnabar)
        
        .onAppear {
            self.viewModel.appRouter = self.appRouter
            self.viewModel.sessionStore = self.sessionStore
            
            self.viewModel.onAppear()
        }
    }
}

fileprivate struct SplashView_Content: View {
    let animation: Namespace.ID
    
    var body: some View {
        R.image.apple.fill.flag2Crossed
            .toFitFrame(side: 70)
            .foregroundColor(R.color.perm.white)
            .matchedGeometryEffect(id: C.matchedGeometry.onboardingLogo, in: self.animation)
            .zStackBackground(R.color.cinnabar)
    }
}

fileprivate struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(viewModel: SplashViewModel())
            .environmentObject(AppRouter())
            .environmentObject(SessionStore())
    }
}
