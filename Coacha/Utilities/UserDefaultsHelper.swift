//
//  UserDefaultsHelper.swift
//  Coacha
//
//  Created by Anthony Šimek on 06.03.2022.
//

import Foundation

final class UserDefaultsHelper: ObservableObject {
    fileprivate enum Key: String {
        case hasRunBefore = "hasRunBefore"
    }
    
    fileprivate let ud = UserDefaults.standard
}

extension UserDefaultsHelper {
    // MARK: - LIFE_CYCLE
    var hasRunBefore: Bool {
        get {
            return (ud.object(forKey: Key.hasRunBefore.rawValue) as? Bool) ?? false
        }
        set (newValue) {
            ud.set(newValue, forKey: Key.hasRunBefore.rawValue)
            ud.synchronize()
        }
    }
}
