//
//  SignUp2ViewController.swift
//  Sportly
//
//  Created by MN on 25.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

class SignUp2ViewController: UIViewController {
    var viewModel: SignUp2ViewModelType!
    
    @IBOutlet weak var tableView: UITableView!
    
    let nextButton = UIBarButtonItem(title: "Next", style: .done, target: SignUp2ViewController.self, action: nil)
    let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .done, target: SignUp2ViewController.self, action: nil)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTV()
        registerCells()
        setupNav()
        reloadRightBarButton()
//        navigationItem.backBarButtonItem?.isHidden = true
//        navigationItem.leftBarButtonItem?.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func bind() {
        viewModel.onReload = { [weak self] changes in
            guard let self = self else { return }
            if changes != .none {
                self.tableView.performBatchUpdates {
                    self.tableView.insertSections(changes.insertedSection, with: .top)
                    self.tableView.deleteSections(changes.removedSection, with: .bottom)
                    self.tableView.insertRows(at: changes.inserted, with: .none)
                    self.tableView.deleteRows(at: changes.removed, with: .none)
                    self.tableView.reloadRows(at: changes.updated, with: .none)
                }
            }
        }
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
    
    @objc private func goNext() {
        viewModel.signUpTapped(view: view)
    }
    
    @objc private func goBack() {
//        viewModel.goBack()
    }
    
    private func setupNav() {
        navigationController?.navigationBar.isTranslucent = true
        
//        nextButton.tintColor = UIColor(projColors: .gray)
        
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
    
    private func setupTV() {
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
//MARK: - UIGestureRecognizerDelegate
extension SignUp2ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
           return true
       }
}
//MARK: - UITableViewDelegate
extension SignUp2ViewController: UITableViewDelegate {
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
//MARK: - UITableViewDataSource
extension SignUp2ViewController: UITableViewDataSource {
    
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
