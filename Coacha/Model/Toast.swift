//
//  Toast.swift
//  Coacha
//
//  Created by Anthony Šimek on 08.03.2022.
//

import SwiftUI

struct Toast {
    enum ToastType {
        case successAdd, successRemove
    }
    
    let toastType: ToastType
    let storageType: StorageType
    
    var title: String {
        get {
            switch toastType {
                case .successAdd:
                    return "toast.success.add"
                case .successRemove:
                    return "toast.success.remove"
            }
        }
    }
    
    var iconColor: Color {
        get {
            switch storageType {
                case .local:
                    return R.color.pelorous
                case .remote:
                    return R.color.perm.cinnabar
                default:
                    return R.color.perm.cinnabar
            }
        }
    }
    
    init(toastType: ToastType, storageType: StorageType) {
        self.toastType = toastType
        self.storageType = storageType
    }
}
