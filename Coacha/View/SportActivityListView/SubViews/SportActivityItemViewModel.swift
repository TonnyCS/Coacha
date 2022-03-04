//
//  SportActivityItemViewModel.swift
//  Coacha
//
//  Created by Anthony Šimek on 04.03.2022.
//

import SwiftUI

final class SportActivityItemViewModel: ObservableObject {
    let name: String
    let place: String
    let date: String
    let backgroundColor: Color
    
    init(name: String, place: String, date: Date, isLocal: Bool) {
        self.name = name
        self.place = place
        self.date = "\(date.get(.day)).\(date.get(.month)).\(date.get(.year))"
        self.backgroundColor = isLocal ? R.color.cinnabar : R.color.white
    }
}
