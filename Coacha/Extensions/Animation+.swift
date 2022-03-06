//
//  Animation+.swift
//  Coacha
//
//  Created by Anthony Šimek on 06.03.2022.
//

import SwiftUI

extension Animation {
    func `repeat`(while expression: Bool, autoreverses: Bool = true) -> Animation {
        if expression {
            return self.repeatForever(autoreverses: autoreverses)
        } else {
            return self
        }
    }
}
