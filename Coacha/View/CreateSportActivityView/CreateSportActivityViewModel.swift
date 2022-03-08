//
//  CreateSportActivityViewModel.swift
//  Coacha
//
//  Created by Anthony Šimek on 04.03.2022.
//

import SwiftUI
import Combine

final class CreateSportActivityViewModel: CommonErrorHandlingViewModel {
    var viewDismissalModePublished = PassthroughSubject<Void, Never>()
    @ObservedObject var remoteDataStore: RemoteDataStore = RemoteDataStore()
    @ObservedObject var localDataStore: LocalDataStore = LocalDataStore()
    @ObservedObject var appRouter: AppRouter = AppRouter()
    
    @Published var name: String = "" { didSet { self.checkForSaveButtonDisable() } }
    @Published var place: Place? { didSet { self.checkForSaveButtonDisable() } }
    @Published var duration: DateDuration = DateDuration(hours: 0, minutes: 30) { didSet { self.checkForSaveButtonDisable() } }
    
    @Published var saveButtonDisabled: Bool = true
    
    @Published var showingConfirmationSheet: Bool = false
    @Published var showingLocationSheet: Bool = false
    
    func createRemoteSportActivity() {
        self.showLoading()
        
        self.remoteDataStore.putSportActivity(
            sportActivity: RemoteSportActivity(
                name: self.name,
                place: self.place?.place.name ?? "N/A",
                duration: self.duration
            )
        ) { result in
            switch result {
                case .success(_):
                    self.dismissView()
                    self.appRouter.showToast(with: Toast(toastType: .successAdd, storageType: .remote))
                case .failure(let error):
                    self.dismissLoading()
                    self.showError(error: error)
            }
        }
    }
    
    func createLocalSportActivity() {
        self.showLoading()
        
        self.localDataStore.add(
            sportActivity: LocalSportActivity(
                name: self.name,
                place: self.place?.place.name ?? "N/A",
                duration: self.duration
            )
        ) { result in
            switch result {
                case .success(_):
                    self.dismissView()
                    self.appRouter.showToast(with: Toast(toastType: .successAdd, storageType: .local))
                case .failure(let error):
                    self.dismissLoading()
                    self.showError(error: error)
            }
        }
    }
    
    // MARK: - UI
    private func checkForSaveButtonDisable() {
        self.saveButtonDisabled = self.name.isEmpty || self.place == nil || (self.duration.hours + self.duration.minutes) == 0
    }
    
    func showConfirmationSheet() {
        self.showingConfirmationSheet = true
    }
    
    func showLocationSheet() {
        self.showingLocationSheet = true
    }
    
    func dismissView() {
        self.viewDismissalModePublished.send(())
    }
}
