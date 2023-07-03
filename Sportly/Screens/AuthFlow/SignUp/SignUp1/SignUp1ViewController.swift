//
//  SignUp1ViewController.swift
//  Sportly
//
//  Created by MN on 25.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

class SignUp1ViewController: UIViewController {
    var viewModel: SignUp1ViewModelType!
    
    @IBOutlet weak var tableView: UITableView!
    let nextButton = UIBarButtonItem(title: "Next", style: .done, target: SignUp1ViewController.self, action: nil)
    let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .done, target: SignUp1ViewController.self, action: nil)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
        reloadRightBarButton()
        viewModel.reloadButton()
        navigationItem.leftBarButtonItem?.isEnabled = true
        navigationItem.leftBarButtonItem?.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTV()
        registerCells()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationItem.leftBarButtonItem?.isEnabled = true
        navigationItem.leftBarButtonItem?.isHidden = false
    }
    
    private func reloadRightBarButton() {
        viewModel.reloadBarButton = { [weak self] type in
            guard let self = self else { return }
            switch type {
            case .enableButton:
                self.nextButton.isEnabled = true
                self.nextButton.target = self
                self.nextButton.action = #selector(self.goNext)
            case .disableButton:
                self.nextButton.isEnabled = false
            }
        }
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.isTranslucent = true
        
        nextButton.tintColor = UIColor(projColors: .gray)
        
        let font = UIFont.boldSystemFont(ofSize: 22)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor(projColors: .green1),
            .paragraphStyle: createParagraphStyle(alignment: .right)
        ]
        nextButton.setTitleTextAttributes(attributes, for: .normal)
        nextButton.isEnabled = false
        
        navigationItem.rightBarButtonItem = nextButton
        
        backButton.action = #selector(goBack)
        backButton.target = self
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
    }
    
    @objc private func goNext() {
        viewModel.goNext()
    }
    
    @objc private func goBack() {
        viewModel.goBack()
    }
    
    func setupTV() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: PlaceholderTVCell.identifier, bundle: .main), forCellReuseIdentifier: PlaceholderTVCell.identifier)
        tableView.register(UINib(nibName: TextTVCell.identifier, bundle: .main), forCellReuseIdentifier: TextTVCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "default")
    }
    
    func createParagraphStyle(alignment: NSTextAlignment) -> NSParagraphStyle {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        return paragraphStyle
    }
}

extension SignUp1ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let item = viewModel.getItem(indexPath: indexPath) else { return .leastNormalMagnitude}
        switch item {
            
        case .userName(_): return 60
        case .firstName(_): return 60
        case .lastName(_): return 60
        case .email(_): return 60
        case .createPassword(_): return 60
        case .confirmPassword(_): return 60
        case .title(_): return 150
        case .text(_): return 10
        case .spacing(let size): return size
        }
    }
}

extension SignUp1ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
           return true
       }
}

extension SignUp1ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getItemsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = viewModel.getItem(indexPath: indexPath) else { return .init() }
        switch item {
            
        case .userName(let cellVM):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PlaceholderTVCell.identifier, for: indexPath) as? PlaceholderTVCell else { return .init() }
            cell.configure(with: cellVM)
            return cell
        case .firstName(let cellVM):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PlaceholderTVCell.identifier, for: indexPath) as? PlaceholderTVCell else { return .init() }
            cell.configure(with: cellVM)
            return cell
        case .lastName(let cellVM):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PlaceholderTVCell.identifier, for: indexPath) as? PlaceholderTVCell else { return .init() }
            cell.configure(with: cellVM)
            return cell
        case .email(let cellVM):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PlaceholderTVCell.identifier, for: indexPath) as? PlaceholderTVCell else { return .init() }
            cell.configure(with: cellVM)
            return cell
        case .createPassword(let cellVM):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PlaceholderTVCell.identifier, for: indexPath) as? PlaceholderTVCell else { return .init() }
            cell.configure(with: cellVM)
            return cell
        case .confirmPassword(let cellVM):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PlaceholderTVCell.identifier, for: indexPath) as? PlaceholderTVCell else { return .init() }
            cell.configure(with: cellVM)
            return cell
        case .title(let cellVM):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TextTVCell.identifier, for: indexPath) as? TextTVCell else { return .init() }
            cell.configure(with: cellVM)
            return cell
        case .text(let cellVM):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TextTVCell.identifier, for: indexPath) as? TextTVCell else { return .init() }
            cell.configure(with: cellVM)
            return cell
        case .spacing:
            let cell = tableView.dequeueReusableCell(withIdentifier: "default", for: indexPath)
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            return cell
        }
    }
}
