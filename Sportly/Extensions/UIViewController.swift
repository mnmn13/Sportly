//
//  UIViewController.swift
//  Sportly
//
//  Created by MN on 11.05.2023.
//

import UIKit

extension UIViewController {
    class var identifier: String {
        let separator = "."
        let fullName = String(describing: self)
        if fullName.contains(separator) {
            let items = fullName.components(separatedBy: separator)
            if let name = items.last {
                return name
            }
        }
        return fullName
    }
}
