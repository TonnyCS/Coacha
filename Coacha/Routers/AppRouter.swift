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
//        case login
//        case registration
        case splash
    }
    
    @Published var currentPage: Page = .splash
    
    public func setCurrentPage(to page: Page) {
        withAnimation {
            self.currentPage = page
        }
    }
}
