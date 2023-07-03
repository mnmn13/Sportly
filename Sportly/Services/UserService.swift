//
//  UserService.swift
//  Sportly
//
//  Created by MN on 25.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

class UserService: Service {
    
    private let authManager = FirebaseAuthManager.shared
    private let dataBaseManager = FirebaseRealtimeDatabaseManager.shared
    
    func signUpWithEmail(user: UserRegistration, completion: @escaping ResultClosure<String, Error>) {
        guard let email = user.email, let password = user.password, let firstName = user.firstName, let lastName = user.lastName, let userName = user.userName else { return }
        authManager.signUp(email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .failure(let error): completion(.failure(error))
            case .success(let firebaseUser):
                let userInfo = UserInfo(userName: userName, firstName: firstName, lastName: lastName, email: email, uid: firebaseUser.uid)
                let user = UserModel(firstEntry: true, userInfo: userInfo)
                self.dataBaseManager.createUserInDatabase(user: user) { boolResult in
                    
                    if boolResult == true {
                        UserDefaults.standard.saveUser(user: user)
                    }
                    completion(.success("Success"))
                }
            }
//            let userInfo = UserInfo(userName: userName, firstName: firstName, lastName: lastName, email: email)
//            let user = UserModel(firstEntry: true, userInfo: userInfo)
//
//            self.dataBaseManager.createUserInDatabase(user: user) { bool in
//////                UserDefaults.standard.saveUser(user: user)
//                completion(bool)
//            }
        }
    }
    
    func signInWithEmail(email: String, password: String, completion: @escaping SimpleClosure<Bool>) {
        
    }
    
    
    
    
    
    
}
