//
//  RealmManager.swift
//  Sportly
//
//  Created by MN on 05.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import RealmSwift

class RealmManager {
    
    static let shared = RealmManager()
    
    private init() {}
    
//    private var realm = try! Realm()
    
    
    func saveData(_ object: Object) {
            
//        do {
//            try realm.write({ [weak self] in
//                self?.realm.add(object)
//            })
//        } catch let error {
//            print(error.localizedDescription)
//        }
//        realm.writeAsync { [weak self] in
//            self?.realm.add(object)
//        }
    }
    
    func getData() {
//        realm.writeAsync { [weak self] in

//        }
        
    }
    
//    func getByType<T>(by type: T.Type = T.self, data: Decodable) -> T {
//        
//        type.init(data)
//        
//        
//    }
    
    
    
    
    func resetAllDatabase() {
//        realm.writeAsync { [weak self] in
//            self?.realm.deleteAll()
        }
//    }
    
}
