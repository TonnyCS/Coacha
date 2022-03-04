//
//  CreateSportActivityViewModel.swift
//  Coacha
//
//  Created by Anthony Šimek on 04.03.2022.
//

import SwiftUI
import Combine

final class CreateSportActivityViewModel: CommonErrorHandlingViewModel {
    var viewDismissalModePublished = PassthroughSubject<Bool, Never>()
    @ObservedObject var dataStore: DataStore = DataStore()
    
    @Published var name: String = "" { didSet { self.checkForSaveButtonDisable() } }
    @Published var place: String = "" { didSet { self.checkForSaveButtonDisable() } }
    @Published var duration: Int = 0 { didSet { self.checkForSaveButtonDisable() } }
    
    @Published var saveButtonDisabled: Bool = true
    
    func createNewSportActivity() {
        self.showLoading()
        
        self.dataStore.putSportActivity(sportActivity: SportActivity(name: self.name, place: self.place, duration: self.duration)) { error in
            if let error = error {
                self.dismissLoading()
                self.showError(error: error)
            } else {
                self.dismissView()
            }
        }
    }
    
    // MARK: - UI
    private func checkForSaveButtonDisable() {
        self.saveButtonDisabled = self.name.isEmpty || self.place.isEmpty || self.duration == 0
    }
    
    private func dismissView() {
        self.viewDismissalModePublished.send(true)
    }
}
