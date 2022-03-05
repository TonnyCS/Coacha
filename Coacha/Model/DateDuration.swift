//
//  DateDuration.swift
//  Coacha
//
//  Created by Anthony Šimek on 05.03.2022.
//

import Foundation

struct DateDuration: Codable {
    var value: Int
    var unit: Unit
    
    enum Unit: String, CaseIterable, Codable {
        case minutes, hours
    }
}
