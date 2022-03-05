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
    @Published var place: Place? { didSet { self.checkForSaveButtonDisable() } }
    @Published var duration: DateDuration = DateDuration(value: 0, unit: .minutes) { didSet { self.checkForSaveButtonDisable() } }
    
    @Published var saveButtonDisabled: Bool = true
    
    @Published var showingConfirmationSheet: Bool = false
    @Published var showingLocationSheet: Bool = false
    
    func createRemoteSportActivity() {
        self.showLoading()
        
        self.dataStore.putSportActivity(sportActivity: SportActivity(name: self.name, place: self.place?.place.name ?? "N/A", duration: self.duration.value, isLocal: false)) { error in
            if let error = error {
                self.dismissLoading()
                self.showError(error: error)
            } else {
                self.dismissView()
            }
        }
    }
    
    func createLocalSportActivity() { //TODO
        LocalStore.shared.add(sportActivity: SportActivity(name: self.name, place: self.place?.place.name ?? "N/A", duration: self.duration.value, isLocal: true))
        self.dismissView()
    }
    
    // MARK: - UI
    private func checkForSaveButtonDisable() {
        self.saveButtonDisabled = self.name.isEmpty || self.place == nil || self.duration.value == 0
    }
    
    func showConfirmationSheet() {
        self.showingConfirmationSheet = true
    }
    
    func showLocationSheet() {
        self.showingLocationSheet = true
    }
    
    func dismissView() {
        self.viewDismissalModePublished.send(true)
    }
}
