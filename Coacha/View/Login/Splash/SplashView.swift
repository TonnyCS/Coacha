//
//  SplashView.swift
//  Coacha
//
//  Created by Anthony Šimek on 04.03.2022.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var sessionStore: SessionStore
    @EnvironmentObject var appRouter: AppRouter
    
    @StateObject var viewModel: SplashViewModel
    
    var body: some View {
        VStack {
            if self.viewModel.showingLoading {
                LoadingView(color: R.color.perm.white)
            } else {
                Button(action: self.viewModel.login) {
                    Text("Login")
                        .medium14(R.color.white)
                }
            }
        }
        .zStackBackground(R.color.cinnabar)
        
        .alert(isPresented: self.$viewModel.showingAlert) {
            Alert(title: Text(self.viewModel.alertTitle), message: Text(self.viewModel.alertMessage), dismissButton: .default(Text("general.cancel".localized)))
        }
        
        .onAppear {
            self.viewModel.appRouter = self.appRouter
            self.viewModel.sessionStore = self.sessionStore
            
            self.viewModel.onAppear()
        }
    }
}

fileprivate struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(viewModel: SplashViewModel())
            .environmentObject(AppRouter())
    }
}
