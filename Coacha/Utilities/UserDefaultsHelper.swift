//
//  UserDefaultsHelper.swift
//  Coacha
//
//  Created by Anthony Šimek on 06.03.2022.
//

import Foundation

typealias UD = UserDefaultsHelper

final class UserDefaultsHelper {
    fileprivate enum Key: String {
        case hasRunBefore = "hasRunBefore"
    }
    
    static var shared: UserDefaultsHelper = UserDefaultsHelper()
    
    fileprivate let ud = UserDefaults.standard
    
    private init() {}
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
