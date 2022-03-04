//
//  SportActivityListViewModel.swift
//  Coacha
//
//  Created by Anthony Šimek on 04.03.2022.
//

import SwiftUI

enum StorageType: Int {
    case local
    case remote
    case all
}

final class SportActivityListViewModel: ObservableObject {
    @Published var storageType: StorageType = .all //TODO
    
    @Published var showingNewSportActivityView: Bool = false
}
