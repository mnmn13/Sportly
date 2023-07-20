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
        collectionView.register(DetailedPlayerStatsCVCell.self, forCellWithReuseIdentifier: DetailedPlayerStatsCVCell.identifier)
    }
    
    // MARK: - UICollectionViewCompositionalLayout
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalHeight(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let interItemSpacing: CGFloat = 20
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(180), heightDimension: .absolute(180))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        group.interItemSpacing = .fixed(interItemSpacing)
//        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = interItemSpacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 40)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    // Hide separator
    func hideSeparator() {
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 800)
    }
    
    // MARK: - Configure
    func configure(_ viewModel: DetailedPlayerStatsMainCellVM) {
        self.viewModel = viewModel
        bindForReload()
        self.viewModel?.convetData()
        setupContent()
    }
    
    private func bindForReload() {
        viewModel?.onReload = { [weak self] changes in
            guard let self = self else { return }
            if changes != .none {
                self.collectionView.performBatchUpdates {
                    self.collectionView.insertSections(changes.insertedSection)
                    self.collectionView.deleteSections(changes.removedSection)
                    self.collectionView.insertItems(at: changes.inserted)
                    self.collectionView.deleteItems(at: changes.removed)
                    self.collectionView.reloadItems(at: changes.updated)
                }
            }
//            self.collectionView.reloadData()
        }
    }
    
    // MARK: - Constraints
    private func setupConstraints() {
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.bottom.equalTo(contentView.snp.bottom)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
//            make.height.equalTo(200)
        }
//        collectionView.snp.makeConstraints { make in
//            make.top.equalToSuperview()
//            make.bottom.equalToSuperview()
//            make.leading.equalToSuperview()
//            make.trailing.equalToSuperview()
//
//        }
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
        viewModel?.numberOfItems() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = viewModel?.getItem(indexPath: indexPath) else { return collectionView.dequeueReusableCell(withReuseIdentifier: "empty", for: indexPath) }
        switch item {
        case .playerCard(let detailedPlayerStatsCVCellVM):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailedPlayerStatsCVCell.identifier, for: indexPath) as? DetailedPlayerStatsCVCell else { return collectionView.dequeueReusableCell(withReuseIdentifier: "empty", for: indexPath) }
            cell.configure(detailedPlayerStatsCVCellVM)
            return cell
        }
    }
}
