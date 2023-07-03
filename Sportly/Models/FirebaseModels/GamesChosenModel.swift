//
//  GamesChosenModel.swift
//  Sportly
//
//  Created by MN on 02.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

struct GamesChosenModel: HashCoded {
    var footBall: Bool = false
    var basketball: Bool = false
    var baseball: Bool = false
    var volleyball: Bool = false
    var NBA: Bool = false
    var rugby: Bool = false
    var hockey: Bool = false
    
    func isEmpty() -> Bool {
        return footBall || basketball || baseball || volleyball || NBA || rugby || hockey
    }
}
