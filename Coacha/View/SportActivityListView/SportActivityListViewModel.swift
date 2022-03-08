//
//  SportActivityListViewModel.swift
//  Coacha
//
//  Created by Anthony Šimek on 04.03.2022.
//

import SwiftUI
import Combine

enum StorageType: Int {
    case local
    case remote
    case all
}

final class SportActivityListViewModel: CommonErrorHandlingViewModel {
    @ObservedObject var remoteDataStore: RemoteDataStore = RemoteDataStore()
    @ObservedObject var localDataStore: LocalDataStore = LocalDataStore()
    @ObservedObject var appRouter: AppRouter = AppRouter()
    
    @Published var sportActivities: [SportActivity] = []
    
    @Published var storageType: StorageType = .all
    @Published var showingNewSportActivityView: Bool = false
    
    override init() {
        super.init()
    }
    
    func refreshArray() {
        var array = [SportActivity]()

        let localSportActivity = localDataStore.localSportActivity.value.map { $0.sportActivity }
        let remoteSportActivity = remoteDataStore.remoteSportActivity.value

        switch storageType {
            case .all:
                array = remoteSportActivity + localSportActivity
            case .local:
                array = localSportActivity
            case .remote:
                array = remoteSportActivity
        }

        let sortedArray = array.sorted(by: { $0.date > $1.date })
        withAnimation(.easeInOut(duration: 0.3)) {
            self.sportActivities = sortedArray
        }
    }
    
    func deleteSportActivity(id: UUID, isLocal: Bool) {
        if isLocal {
            self.deleteLocalActivity(id: id)
        } else {
            self.deleteRemoteActivity(id: id)
        }
    }
    
    private func deleteRemoteActivity(id: UUID) {
        self.remoteDataStore.deleteSportActivity(id: id) { result in
            switch result {
                case .success(_):
                    self.appRouter.showToast(with: Toast(toastType: .successRemove, storageType: .remote))
                case .failure(let error):
                    self.showError(error: error)
            }
        }
    }
    
    private func deleteLocalActivity(id: UUID) {
        self.localDataStore.delete(id: id) { result in
            switch result {
                case .success(_):
                    self.appRouter.showToast(with: Toast(toastType: .successRemove, storageType: .local))
                case .failure(let error):
                    self.showError(error: error)
            }
        }
    }
    
    func onPlusButtonClicked() {
        withAnimation {
            self.showingNewSportActivityView = true
        }
    }
}
