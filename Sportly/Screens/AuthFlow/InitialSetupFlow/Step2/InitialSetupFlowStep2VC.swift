//
//  WelcomeFlowStep2VC.swift
//  Sportly
//
//  Created by MN on 25.05.2023.
//

import UIKit

class InitialSetupFlowStep2VC: UIViewController {
    
    private var tableView = UITableView()
    
    var viewModel: InitialSetupFlowStep2VMType!
    let nextButton = UIBarButtonItem(title: "Skip", style: .done, target: SignUp1ViewController.self, action: nil)
    let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .done, target: InitialSetupFlowStep1VC.self, action: nil)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        setupTV()
        bindForReload()
        reloadRightBarButton()
        setupNav()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func bindForReload() {
        viewModel.onReload = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func reloadRightBarButton() {
        viewModel.reloadBarButton = { [weak self] type in
            guard let self = self else { return }
            switch type {
            case .enableButton:
//                self.nextButton.isEnabled = true
                self.nextButton.title = "Next"
                let font = UIFont.boldSystemFont(ofSize: 22)
                let attributes: [NSAttributedString.Key: Any] = [
                    .font: font,
                    .foregroundColor: UIColor(projColors: .green1),
                    .paragraphStyle: createParagraphStyle(alignment: .right)
                ]
                self.nextButton.setTitleTextAttributes(attributes, for: .normal)
                self.nextButton.target = self
                self.nextButton.action = #selector(self.goNext)
            case .disableButton:
                self.nextButton.title = "Skip"
                let font = UIFont.boldSystemFont(ofSize: 22)
                let attributes: [NSAttributedString.Key: Any] = [
                    .font: font,
                    .foregroundColor: UIColor(projColors: .gray),
                    .paragraphStyle: createParagraphStyle(alignment: .right)
                ]
                nextButton.setTitleTextAttributes(attributes, for: .normal)
//                self.nextButton.isEnabled = false
            }
        }
    }
    
    private func setupNav() {
        navigationController?.navigationBar.isTranslucent = true
        
//        nextButton.tintColor = UIColor(projColors: .gray)
        
        let font = UIFont.boldSystemFont(ofSize: 22)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor(projColors: .gray),
            .paragraphStyle: createParagraphStyle(alignment: .right)
        ]
        nextButton.setTitleTextAttributes(attributes, for: .normal)
        nextButton.target = self
        nextButton.action = #selector(goNext)
        nextButton.isEnabled = true
        
        navigationItem.rightBarButtonItem = nextButton
        
        backButton.action = #selector(goBack)
        backButton.target = self
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    @objc private func goNext() {
        viewModel.nextTapped()
    }
    
    
    @objc private func goBack() {
        viewModel.backTapped()
    }
    
    private func setupConstraints() {
//        guard let superview = view.superview else { return }
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupTV() {
        setupConstraints()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        registerCells()
    }
    
    private func registerCells() {
        tableView.register(BubblesTVCell.self, forCellReuseIdentifier: BubblesTVCell.identifier)
        tableView.register(UINib(nibName: TextTVCell.identifier, bundle: .main), forCellReuseIdentifier: TextTVCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellReuseIdentifier")
    }
    
    private func createParagraphStyle(alignment: NSTextAlignment) -> NSParagraphStyle {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        return paragraphStyle
    }
}

extension InitialSetupFlowStep2VC: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}

extension InitialSetupFlowStep2VC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let item = viewModel.getItem(indexPath: indexPath) else { return .leastNormalMagnitude}
        switch item {
        case .bubbles: return 650
        case .text: return 150
        case .spacing(let cGFloat): return cGFloat
        }
    }
}
extension InitialSetupFlowStep2VC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getItemsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let item = viewModel.getItem(indexPath: indexPath) else { return .init() }
        
        switch item {
        case .bubbles(let bubblesCellVM):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BubblesTVCell.identifier, for: indexPath) as? BubblesTVCell else { return .init() }
            cell.configure(bubblesCellVM)
            cell.selectionStyle = .none
            return cell
        case .text(let textTVCellVM):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TextTVCell.identifier, for: indexPath) as? TextTVCell else { return .init() }
            cell.configure(with: textTVCellVM)
            cell.selectionStyle = .none
            return cell
        case .spacing:
            return .init()
        }
    }
}
