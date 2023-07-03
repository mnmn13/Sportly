//
//  TextTVCellVM.swift
//  Sportly
//
//  Created by MN on 28.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

struct TextTVCellVM: Hashable {
    
    var text: String
    var cellType: TextCellType
}

enum TextCellType {
    case title
    case upperTFText
}

//extension TextTVCellVM: Hashable {
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(text)
//        hasher.combine(cellType)
//    }
//
//    static func == (lhs: TextTVCellVM, rhs: TextTVCellVM) -> Bool {
//        lhs.text == rhs.text && lhs.cellType == rhs.cellType
//    }
//}
