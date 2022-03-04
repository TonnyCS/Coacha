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

final class SportActivityListViewModel: ObservableObject {
    private var cancellable: AnyCancellable?
    @ObservedObject var dataStore: DataStore = DataStore()
    
    @Published var storageType: StorageType = .all //TODO
    @Published var showingNewSportActivityView: Bool = false
    
    @Published var allSportActivity: [SportActivity] = []
    
    init() {
        let sportActivityPublisher = LocalStore.shared.allSportActivity.eraseToAnyPublisher()
        
        cancellable = sportActivityPublisher
            .sink(receiveValue: { allSportActivity in
                self.allSportActivity = allSportActivity.map { $0.sportActivity }
            })
    }
    
    func getArray() -> [SportActivity] {
        var array = [SportActivity]()
        
        switch storageType {
            case .all:
                array = dataStore.allSportActivity + allSportActivity
            case .local:
                array = allSportActivity
            case .remote:
                array = dataStore.allSportActivity
        }
        
        let sortedArray = array.sorted(by: { $0.date > $1.date })
        return sortedArray
    }
}
