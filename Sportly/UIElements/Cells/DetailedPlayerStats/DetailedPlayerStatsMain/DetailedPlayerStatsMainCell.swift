//
//  DetailedPlayerStatsMainCell.swift
//  Sportly
//
//  Created by MN on 30.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

class DetailedPlayerStatsMainCell: UITableViewCell {
    
    static let identifier = String(describing: DetailedPlayerStatsMainCell.self)
    
    private var viewModel: DetailedPlayerStatsMainCellVM?
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .infinite, collectionViewLayout: createLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        registerCells(collectionView)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
    }
    
    // MARK: - Register cells
    private func registerCells(_ collectionView: UICollectionView) {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "empty")
        collectionView.register(DetailedTableGroupsTitleCell.self, forCellWithReuseIdentifier: DetailedTableGroupsTitleCell.identifier)
    }
    
    // MARK: - UICollectionViewCompositionalLayout
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(150), heightDimension: .absolute(30))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 0)
        let interItemSpacing: CGFloat = 15
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(500), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .flexible(interItemSpacing)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 40)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    // Hide separator
    func hideSeparator() {
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 800)
    }
    
    // MARK: - Configure
    func configure(_ viewModel: DetailedPlayerStatsMainCellVM) {
        self.viewModel = viewModel
        setupContent()
    }
    
    // MARK: - Constraints
    private func setupConstraints() {
        
    }
    
    // MARK: - Content
    private func setupContent() {
        
    }
}

// MARK: - UICollectionViewDelegate
extension DetailedPlayerStatsMainCell: UICollectionViewDelegate {}

// MARK: - UICollectionViewDataSource
extension DetailedPlayerStatsMainCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        .init()
    }
}
