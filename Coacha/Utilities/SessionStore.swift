//
//  SessionStore.swift
//  Coacha
//
//  Created by Anthony Šimek on 04.03.2022.
//

import SwiftUI
import Firebase
import AuthenticationServices
import CryptoKit

class SessionStore: ObservableObject {
    func checkForAlreadySignedInUser(completion: @escaping (_ error: Error?) -> Void) {
        Auth.auth().addStateDidChangeListener { _, user in
            if let user = user {
                debugPrint("SESSION_STORE/CHECK_FOR_ALREADY_SIGNED_IN_USER: UserID: \(user.uid)")
                completion(nil)
            } else {
                debugPrint("SESSION_STORE/CHECK_FOR_ALREADY_SIGNED_IN_USER: Error: Noone signed in.")
                completion(ErrorWithCustomMessage(msg: "general.error"))
            }
        }
    }
    
    func signInAnonymously(completion: @escaping (_ user: User?, _ error: Error?) -> Void) {
        Auth.auth().signInAnonymously { authResult, error in
            if let error = error {
                debugPrint("SESSION_STORE/SIGN_IN_ANONYMOUSLY: Error: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            
            guard let user = authResult?.user else { return }
            debugPrint("SESSION_STORE/SIGN_IN_ANONYMOUSLY: Success | UserID: \(user.uid)")            
            completion(user, nil)
        }
    }
    
    func signOut(completion: @escaping (_ error: Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            debugPrint("SESSION_STORE/OUT: Success")
            completion(nil)
        } catch let nsError as NSError {
            debugPrint("SESSION_STORE/OUT: Error: \(nsError.localizedDescription)")
            completion(nsError)
        }
    }
}
