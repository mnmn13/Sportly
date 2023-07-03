//
//  LegalInformationViewController.swift
//  Sportly
//
//  Created by MN on 30.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

class LegalInformationViewController: UIViewController {
    
    var viewModel: LegalInformationViewModelType!
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = viewModel.getText()
    }
}
