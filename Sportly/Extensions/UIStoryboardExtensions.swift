//
//  UIStoryboardExtensions.swift
//  Sportly
//
//  Created by MN on 11.05.2023.
//

import UIKit

struct Storyboard {
    //MARK: - Pre login / login
    static let welcome = UIStoryboard(name: "Welcome", bundle: nil)
    static let signIn = UIStoryboard(name: "SignIn", bundle: nil)
    static let signUp1 = UIStoryboard(name: "SignUp1", bundle: nil)
    static let signUp2 = UIStoryboard(name: "SignUp2", bundle: nil)
    //MARK: - TabBar
    static let home = UIStoryboard(name: "Home", bundle: nil)
    static let discover = UIStoryboard(name: "Discover", bundle: nil)
    static let predict = UIStoryboard(name: "Predict", bundle: nil)
    static let stats = UIStoryboard(name: "Stats", bundle: nil)
    static let profile = UIStoryboard(name: "Profile", bundle: nil)
    
    static let news = UIStoryboard(name: "News", bundle: nil)
    static let statistics = UIStoryboard(name: "Statistics", bundle: nil)
    static let settings = UIStoryboard(name: "Settings", bundle: nil)
    
    static let standings = UIStoryboard(name: "Standings", bundle: nil)
    
    static let legalInformation = UIStoryboard(name: "LegalInformation", bundle: nil)
}

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self.self)
    }
}

extension UIStoryboard {
    
    func controller<T: UIViewController>(withClass: T.Type) -> T? {
        let identifier = withClass.identifier
        return instantiateViewController(withIdentifier: identifier) as? T
    }
    
    func instantiateViewController<T: StoryboardIdentifiable>() -> T? {
        return instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T
    }
}

extension UIViewController: StoryboardIdentifiable { }
