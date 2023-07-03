//
//  UserDefaultsExtensions.swift
//  Sportly
//
//  Created by MN on 27.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

extension UserDefaults {
    var isLoggedIn: Bool {
        get {
            bool(forKey: Key.isLoggedIn)
        } set {
            setValue(newValue, forKey: Key.isLoggedIn)
        }
    }
    
    var isFirstLogin: Bool {
        get {
            bool(forKey: Key.isFirstLogin)
        } set {
            setValue(newValue, forKey: Key.isFirstLogin)
        }
    }
    
    func saveUser(user: UserModel) {
        UserDefaults.standard.set(user.userInfo.userName, forKey: Key.userName)
        UserDefaults.standard.set(user.userInfo.firstName, forKey: Key.firstName)
        UserDefaults.standard.set(user.userInfo.lastName, forKey: Key.lastName)
        UserDefaults.standard.set(user.userInfo.email, forKey: Key.email)
        UserDefaults.standard.set(user.userInfo.uid, forKey: Key.uid)
        UserDefaults.standard.isLoggedIn = true
        print("UserDefaults - user saved ")
    }
    
    func saveUser(user: UserInfo) {
        UserDefaults.standard.set(user.userName, forKey: Key.userName)
        UserDefaults.standard.set(user.firstName, forKey: Key.firstName)
        UserDefaults.standard.set(user.lastName, forKey: Key.lastName)
        UserDefaults.standard.set(user.email, forKey: Key.email)
        UserDefaults.standard.set(user.uid, forKey: Key.uid)
        UserDefaults.standard.isLoggedIn = true
        print("UserDefaults - user saved ")
    }
    
    func getUserData() -> UserInfo? {
        
        guard let usrName = UserDefaults.standard.string(forKey: Key.userName), let fName = UserDefaults.standard.string(forKey: Key.firstName), let lName = UserDefaults.standard.string(forKey: Key.lastName), let uid = UserDefaults.standard.string(forKey: Key.uid), let email = UserDefaults.standard.string(forKey: Key.email) else { return nil }
                return .init(userName: usrName, firstName: fName, lastName: lName, email: email, uid: uid)
    }
    
    func deleteUser() {
        UserDefaults.standard.removeObject(forKey: Key.firstName)
        UserDefaults.standard.removeObject(forKey: Key.lastName)
        UserDefaults.standard.removeObject(forKey: Key.email)
        UserDefaults.standard.removeObject(forKey: Key.uid)
        UserDefaults.standard.isLoggedIn = false
        print("UserDefaults - user zeroed")
    }
}
