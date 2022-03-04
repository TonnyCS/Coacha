//
//  ErrorWithCustomMessage.swift
//  Coacha
//
//  Created by Anthony Šimek on 04.03.2022.
//

import Foundation

struct ErrorWithCustomMessage: Error {
    let msg: String
}

extension ErrorWithCustomMessage: LocalizedError {
    var errorDescription: String? {
        return msg.localized
    }
}
