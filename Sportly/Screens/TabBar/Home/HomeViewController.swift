//
//  HomeViewController.swift
//  Sportly
//
//  Created by MN on 25.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    var viewModel: HomeViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(projColors: .red)
    }
}
