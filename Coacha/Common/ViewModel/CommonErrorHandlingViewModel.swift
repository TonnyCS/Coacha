//
//  CommonErrorHandlingViewModel.swift
//  Coacha
//
//  Created by Anthony Šimek on 04.03.2022.
//

import SwiftUI

class CommonErrorHandlingViewModel: ObservableObject {
    let vibration = UINotificationFeedbackGenerator()
    
    @Published var showingLoading: Bool = false

    @Published var showingAlert: Bool = false
    @Published private(set) var alertTitle: String = ""
    @Published private(set) var alertMessage: String = ""
    
    func showError(title: String = "error.generic.title".localized, message: String = "error.generic.message".localized) {
        self.alertTitle = title
        self.alertMessage = message
        
        vibration.notificationOccurred(.error)
        self.showingAlert.toggle()
    }
    
    func showError(error: Error) {
        self.alertTitle = "error.generic.title".localized
        self.alertMessage = error.localizedDescription
        
        vibration.notificationOccurred(.error)
        self.showingAlert.toggle()
    }

    func showLoading() {
        withAnimation {
            self.showingLoading = true
        }
    }

    func dismissLoading() {
        withAnimation {
            self.showingLoading = false
        }
    }
}
