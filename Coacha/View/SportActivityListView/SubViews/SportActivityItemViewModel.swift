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
    let dateString: String
    let durationString: String
    let storageIcon: Image
    let backgroundColor: Color
    let removeAction: Action
    
    @Published var showingRemoveAlert: Bool = false
    
    // MARK: - SWIPE
    @Published var swipeOffset: CGFloat = 0
    @Published var lastSwipeOffset: CGFloat = 0
    
    init(name: String, place: String, date: Date, duration: DateDuration, isLocal: Bool, removeAction: @escaping Action) {
        self.name = name
        self.place = place
        self.dateString = "\(date.get(.day)).\(date.get(.month)).\(date.get(.year))"
        self.removeAction = removeAction
        self.durationString = "\(duration.hours) h. \(duration.minutes) min."
        
        self.storageIcon = isLocal ? R.image.apple.fill.iphoneCircle : R.image.apple.fill.icloudAndArrowUp
        self.backgroundColor = isLocal ? R.color.pelorous : R.color.cinnabar
    }

    // MARK: - SWIPE
    func onChanged(value: DragGesture.Value) {
        self.swipeOffset = value.translation.width + self.lastSwipeOffset
    }
    
    func onEnd(value: DragGesture.Value) {
        withAnimation {
            if -(value.translation.width + self.lastSwipeOffset) >= 60 && -(value.translation.width + self.lastSwipeOffset) <= UIScreen.main.bounds.width / 2 {
                self.swipeOffset = -84 // Button width
                self.lastSwipeOffset = -84
            } else if -(value.translation.width + self.lastSwipeOffset) > UIScreen.main.bounds.width / 2 {
                self.swipeOffset = -UIScreen.main.bounds.width
                self.lastSwipeOffset = -UIScreen.main.bounds.width
                self.showRemoveSportActivityAlert()
            } else {
                self.swipeOffset = 0
                self.lastSwipeOffset = 0
            }
        }
    }
    
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
