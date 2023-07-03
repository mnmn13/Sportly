//
//  CallbackService.swift
//  Sportly
//
//  Created by MN on 31.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

class CallbackService: Service {
    
    //MARK: - PlaceHolderTVCell
    
    ///Returns callback from createPasswordCell to confirmPasswordCell
    var passwordCallBack: SimpleClosure<String>?
    ///
    var initialSetup1NextTapped: EmptyClosure?
//    var bubbleScreenNextTapped: SimpleClosure<[BubbleChosen]>?
    
}
