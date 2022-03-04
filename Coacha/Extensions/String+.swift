//
//  String+.swift
//  Coacha
//
//  Created by Anthony Šimek on 04.03.2022.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
