//
//  LoginView.swift
//  Coacha
//
//  Created by Anthony Šimek on 06.03.2022.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var appRouter: AppRouter
    @EnvironmentObject var sessionStore: SessionStore
    let animation: Namespace.ID
    
    @StateObject var viewModel: LoginViewModel
    
    var body: some View {
        ZStack {
            if self.viewModel.showingLoading {
                LoginView_Loading(animation: self.animation, showingLoading: self.$viewModel.showingLoading)
            } else {
                LoginView_Content(animation: self.animation, viewModel: self.viewModel)
            }
        }
        .zStackBackground(R.color.perm.cinnabar)
        
        .onAppear {
            self.viewModel.appRouter = self.appRouter
            self.viewModel.sessionStore = self.sessionStore
        }
    }
}

fileprivate struct LoginView_Content: View { //var
    let animation: Namespace.ID
    
    @StateObject var viewModel: LoginViewModel
    
    var body: some View {
        VStack(spacing: 12) {
            R.image.apple.fill.flag2Crossed
                .toFitFrame(side: 70)
                .foregroundColor(R.color.perm.white)
                .matchedGeometryEffect(id: C.matchedGeometry.onboardingLogo, in: animation)
            
            VStack(spacing: 48) {
                VStack(alignment: .trailing, spacing: 4) {
                    Text("general.appname".localized)
                        .bold34(R.color.perm.white, alignment: .center)
                    
                    Text(C.app.appVersion)
                        .regular10(R.color.perm.white)
                }
                
                Button(action: {
                    self.viewModel.login()
                }) {
                    Text("login.button.title".localized)
                        .medium17(R.color.perm.cinnabar)
                        .padding(.all, 16)
                        .commonBackground(R.color.perm.white)
                }
                .scaleableLinkStyle()
            }
        }
        .zStackBackground(R.color.perm.cinnabar)
        
        .alert(isPresented: self.$viewModel.showingAlert) {
            Alert(title: Text(self.viewModel.alertTitle), message: Text(self.viewModel.alertMessage), dismissButton: .default(Text("general.cancel".localized)))
        }
    }
}

fileprivate struct LoginView_Loading: View {
    let animation: Namespace.ID
    @Binding var showingLoading: Bool
    
    @State private var activeAnimation: Bool = false
    
    var body: some View {
        R.image.apple.fill.flag2Crossed
            .toFitFrame(side: 70)
            .foregroundColor(R.color.perm.white)
            .matchedGeometryEffect(id: C.matchedGeometry.onboardingLogo, in: animation)
            .scaleEffect(self.activeAnimation ? 1.08 : 1)
            .animation(.easeInOut(duration: 0.35).repeat(while: showingLoading), value: self.activeAnimation)
            .onAppear {
                self.activeAnimation = true
            }
            .onDisappear {
                self.activeAnimation = false
            }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(animation: Namespace().wrappedValue, viewModel: LoginViewModel())
            .environmentObject(AppRouter())
            .environmentObject(SessionStore())
    }
}
