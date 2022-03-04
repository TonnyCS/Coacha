//
//  SplashView.swift
//  Coacha
//
//  Created by Anthony Šimek on 04.03.2022.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var appRouter: AppRouter
    @StateObject var viewModel: SplashViewModel
    
    var body: some View {
        VStack {
            Button(action: self.viewModel.login) {
                Text("Login")
                    .medium14(R.color.white)
            }
        }
        .zStackBackground(R.color.cinnabar)
        .onAppear {
            self.viewModel.appRouter = self.appRouter
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(viewModel: SplashViewModel())
            .environmentObject(AppRouter())
    }
}
