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
    private var cancellable: AnyCancellable?
    @ObservedObject var remoteDataStore: RemoteDataStore = RemoteDataStore()
    
    @Published var storageType: StorageType = .all //TODO
    @Published var showingNewSportActivityView: Bool = false
    
    @Published var allSportActivity: [SportActivity] = []
    
    override init() {
        super.init()
        
        let sportActivityPublisher = LocalDataStore.shared.allSportActivity.eraseToAnyPublisher()
        
        cancellable = sportActivityPublisher
            .sink(receiveValue: { allSportActivity in
                self.allSportActivity = allSportActivity.map { $0.sportActivity }
            })
    }
    
    func getArray() -> [SportActivity] {
        var array = [SportActivity]()
        
        switch storageType {
            case .all:
                array = remoteDataStore.allSportActivity + allSportActivity
            case .local:
                array = allSportActivity
            case .remote:
                array = remoteDataStore.allSportActivity
        }
        
        let sortedArray = array.sorted(by: { $0.date > $1.date })
        return sortedArray
    }
    
    func deleteSportActivity(id: UUID, isLocal: Bool) {
        if isLocal {
            self.deleteLocalActivity(id: id)
        } else {
            self.deleteRemoteActivity(id: id)
        }
    }
    
    private func deleteLocalActivity(id: UUID) {
        LocalDataStore.shared.delete(id: id) { result in
            switch result {
                case .success(_):
                    debugPrint("SPORT_ACTIVITY_LIST_VM/removeLocal: Success")
                case .failure(let error):
                    self.showError(error: error)
            }
        }
    }
    
    private func deleteRemoteActivity(id: UUID) {
        self.remoteDataStore.deleteSportActivity(id: id) { result in
            switch result {
                case .success(_):
                    debugPrint("SPORT_ACTIVITY_LIST_VM/removeRemote: Success")
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
