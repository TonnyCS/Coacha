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
    
    @Published var storageType: StorageType = .all //TODO
    @Published var showingNewSportActivityView: Bool = false
    
    @Published var allSportActivity: [SportActivityCD] = []
    
    init() {
        let sportActivityPublisher = LocalStore.shared.allSportActivity.eraseToAnyPublisher()
        cancellable = sportActivityPublisher
            .sink(receiveValue: { allSportActivity in
                self.allSportActivity = allSportActivity
            })
    }
}
