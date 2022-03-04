//
//  CoachaAppModel.swift
//  Coacha
//
//  Created by Anthony Šimek on 04.03.2022.
//

import SwiftUI
import Firebase

final class CoachaAppModel: ObservableObject {
    init() {
        FirebaseApp.configure()
    }
}
