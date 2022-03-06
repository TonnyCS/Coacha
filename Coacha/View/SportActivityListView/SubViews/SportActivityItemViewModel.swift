//
//  SportActivityItemViewModel.swift
//  Coacha
//
//  Created by Anthony Šimek on 04.03.2022.
//

import SwiftUI

typealias Action = () -> ()

final class SportActivityItemViewModel: ObservableObject {
    let name: String
    let place: String
    let date: String
    let durationString: String
    let storageType: String
    let removeAction: Action
    
    @Published var showingRemoveAlert: Bool = false
    
    // MARK: - SWIPE
    @Published var swipeOffset: CGFloat = 0
    @Published var lastSwipeOffset: CGFloat = 0
    
    init(name: String, place: String, date: Date, duration: DateDuration, isLocal: Bool, removeAction: @escaping Action) {
        self.name = name
        self.place = place
        self.date = "\(date.get(.day)).\(date.get(.month)).\(date.get(.year))"
        self.durationString = "\(duration.value) \(duration.unit.rawValue)"
        self.storageType = isLocal ? "Local" : "Remote"
        self.removeAction = removeAction
    }
    
    // MARK: - SWIPE
    func showRemoveSportActivityAlert() {
        self.resetOffset()
        
        withAnimation {
            self.showingRemoveAlert = true
        }
    }
    
    private func resetOffset() {
        withAnimation {
            self.swipeOffset = 0
            self.lastSwipeOffset = 0
        }
    }
}
