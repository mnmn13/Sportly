//
//  FirebaseAuthManager.swift
//  Sportly
//
//  Created by MN on 25.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation
import FirebaseAuth

final class FirebaseAuthManager {
    
    static let shared = FirebaseAuthManager()
    
    private init() {}
    
    private let auth = Auth.auth()
    
    func signIn(email: String, password: String, completion: @escaping FirebaseRequestUserClosure<FirebaseAuth.User>) {
        
        auth.signIn(withEmail: email, password: password) { authResult, error in
            if error != nil {
                print(error?.localizedDescription as Any)
                return
            }
            guard let result = authResult else { return }
            completion(result.user)
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        
        auth.createUser(withEmail: email, password: password) { authResult, error in
            
            if let error = error {
                print(error.localizedDescription as Any)
                completion(.failure(error))
                return
            }
            guard let result = authResult else { return }
            completion(.success(result.user))
        }
    }
    
    func logout(completion: SimpleClosure<Bool>) {
        do {
            try auth.signOut()
            completion(true)
        } catch {
            print("Error logout/ user is already logged out")
            completion(false)
        }
    }
    
    func didUserAuthorized() -> Bool {
        guard let userEmail = UserDefaults.standard.getUserData()?.email else { print("The user is not logged in or UserDefault contains an error "); return false }
        return auth.isSignIn(withEmailLink: userEmail)
    }
}
