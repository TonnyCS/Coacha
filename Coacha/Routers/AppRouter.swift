//
//  AppRouter.swift
//  Coacha
//
//  Created by Anthony Šimek on 04.03.2022.
//

import SwiftUI

final class AppRouter: ObservableObject {
    enum Page: Int {
        case main
        case login
        case splash
    }
    
    @Published var currentPage: Page = .splash
    
    @Published var showingToast: Bool = false
    @Published var toast: Toast = Toast(toastType: .successAdd, storageType: .local)
    
    func setCurrentPage(to page: Page) {
        withAnimation {
            self.currentPage = page
        }
    }
    
    func showToast(with toast: Toast) {
        self.toast = toast
        
        withAnimation {
            self.showingToast = true
        }
    }
}
