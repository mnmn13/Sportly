//
//  FirebaseRealtimeDatabaseManager.swift
//  Sportly
//
//  Created by MN on 25.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation
import FirebaseDatabase

final class FirebaseRealtimeDatabaseManager {
    
    static let shared = FirebaseRealtimeDatabaseManager()
    
    private init() {}

    private let database = FirebaseDatabase.Database.database().reference()
}

extension FirebaseRealtimeDatabaseManager {
    
    func createUserInDatabase(user: UserModel, completion: @escaping SimpleClosure<Bool>) {
        let userDict = user.dictionary
        DispatchQueue.global().async { [weak self] in
            self?.database.child(Key.users).child(user.userInfo.uid).setValue(userDict, withCompletionBlock: { error, _ in
                if let error = error {
                    print(error.localizedDescription)
                    completion(false)
                } else {
                    completion(true)
                }
            })
        }
    }
    
    //MARK: - Initial setup
    
    func setInitialGameForUser() {
        
    }
    
    func setInitialLeagueForUser() {
        
    }
    
    func setInitialFavouriteTeamsForUser() {
        
    }
    
    func setInitialGameSetupForUser() {
        
    }
    
//    func test(_ completion: @escaping SimpleClosure<Bool>) {
//        DispatchQueue.global().async { [weak self] in
//            self?.database.child("123").setValue("123", withCompletionBlock: { error, ref in
//                if let error = error {
//                    completion(true)
//                } else {
//                    fatalError()
//                }
//            })
//        }
//    }
    
}
