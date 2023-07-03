//
//  WelcomeViewController.swift
//  Sportly
//
//  Created by MN on 25.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    var viewModel: WelcomeViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTV()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    private func setupTV() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        registerCells()
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: WelcomeLogoCell.identifier, bundle: .main), forCellReuseIdentifier: WelcomeLogoCell.identifier)
        tableView.register(UINib(nibName: WelcomeTitleCell.identifier, bundle: .main), forCellReuseIdentifier: WelcomeTitleCell.identifier)
        tableView.register(UINib(nibName: WelcomeSignUpEmailCell.identifier, bundle: .main), forCellReuseIdentifier: WelcomeSignUpEmailCell.identifier)
        tableView.register(UINib(nibName: WelcomeSignInApple.identifier, bundle: .main), forCellReuseIdentifier: WelcomeSignInApple.identifier)
        tableView.register(UINib(nibName: WelcomeWithoutRegCell.identifier, bundle: .main), forCellReuseIdentifier: WelcomeWithoutRegCell.identifier)
        tableView.register(UINib(nibName: WelcomeOfCell.identifier, bundle: .main), forCellReuseIdentifier: WelcomeOfCell.identifier)
        tableView.register(UINib(nibName: WelcomeLoginCell.identifier, bundle: .main), forCellReuseIdentifier: WelcomeLoginCell.identifier)
        tableView.register(UINib(nibName: WelcomeTermsOfServiceCell.identifier, bundle: .main), forCellReuseIdentifier: WelcomeTermsOfServiceCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "default")
    }
    
    private func setGradientBackground() {
        let colorTop =  UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 1.0).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
}

extension WelcomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let item = viewModel.getItem(indexPath: indexPath) else { return .leastNonzeroMagnitude }
        
        switch item {
        case .logo: return 150
        case .signUpEmail: return 70
        case .signInApple: return 70
        case .withoutRegistration: return 70
        case .spacing(let size): return size
        case .or: return 100
        default: return UITableView.automaticDimension
        }
        
    }
    
}

extension WelcomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getItemsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = viewModel.getItem(indexPath: indexPath) else { return .init() }
        
        switch item {
        case .logo(let cellVM):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WelcomeLogoCell.identifier, for: indexPath) as? WelcomeLogoCell else { return .init() }
            cell.configure(with: cellVM)
            return cell
        case .welcomeTitle(let cellVM):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WelcomeTitleCell.identifier, for: indexPath) as? WelcomeTitleCell else { return .init() }
            cell.configure(with: cellVM)
            return cell
        case .signUpEmail(let cellVM):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WelcomeSignUpEmailCell.identifier, for: indexPath) as? WelcomeSignUpEmailCell else { return .init() }
            cell.configure(with: cellVM)
            return cell
        case .or(let cellVM):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WelcomeOfCell.identifier, for: indexPath) as? WelcomeOfCell else { return .init() }
            cell.configure(with: cellVM)
            return cell
        case .signInApple(let cellVM):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WelcomeSignInApple.identifier, for: indexPath) as? WelcomeSignInApple else { return .init() }
            cell.configure(with: cellVM)
            return cell
        case .withoutRegistration(let cellVM):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WelcomeWithoutRegCell.identifier, for: indexPath) as? WelcomeWithoutRegCell else { return .init() }
            cell.configure(with: cellVM)
            return cell
        case .logIn(let cellVM):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WelcomeLoginCell.identifier, for: indexPath) as? WelcomeLoginCell else { return .init() }
            cell.configure(with: cellVM)
            return cell
        case .termsOfService(let cellVM):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WelcomeTermsOfServiceCell.identifier, for: indexPath) as? WelcomeTermsOfServiceCell else { return .init() }
            cell.configure(with: cellVM)
            return cell
        case .spacing:
            let cell = tableView.dequeueReusableCell(withIdentifier: "default", for: indexPath)
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            return cell
//            return .init()
        }
    }
    
    
}
