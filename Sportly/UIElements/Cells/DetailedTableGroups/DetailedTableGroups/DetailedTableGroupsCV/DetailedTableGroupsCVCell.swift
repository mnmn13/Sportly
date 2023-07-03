//
//  DetailedTableGroupsCVCell.swift
//  Sportly
//
//  Created by MN on 23.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

class DetailedTableGroupsCVCell: UITableViewCell {
    
    static let identifier = String(describing: DetailedTableGroupsCVCell.self)
    
    private var viewModel: DetailedTableGroupsCVCellVM?
    
    // MARK: - CollectionView
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .infinite, collectionViewLayout: createLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        registerCells(collectionView)
        return collectionView
    }()
    
    private var selectedCellIndex: IndexPath?
    
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
    func configure(_ viewModel: DetailedTableGroupsCVCellVM) {
        self.viewModel = viewModel
        bindForReload()
    }
    
    // MARK: - Binding
    func bindForReload() {
        viewModel?.onReload = { [weak self] reloadType in
            switch reloadType {
            case .allWithAnimation:
                self?.collectionView.performBatchUpdates({
                    UIView.animate(withDuration: 0.3) {
                        self?.collectionView.alpha = 0.0
                    }
                }, completion: { finished in
                    self?.collectionView.reloadData()
                    UIView.animate(withDuration: 0.3) {
                        self?.collectionView.alpha = 1.0
                    }
                })
//                self?.collectionView.reloadData()
            case .atIndexWithAnimation:
                break
            }
        }
    }
    
    // MARK: - Constraints
    private func setupConstraints() {
        contentView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDelegate
extension DetailedTableGroupsCVCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.itemSelected(indexPath: indexPath)
        
        collectionView.performBatchUpdates({
            if let previousIndex = selectedCellIndex {
                collectionView.reloadItems(at: [previousIndex])
            }
            selectedCellIndex = indexPath
            collectionView.reloadItems(at: [indexPath])
        }, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource
extension DetailedTableGroupsCVCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.getItemsCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = viewModel?.getItem(indexPath: indexPath) else { return collectionView.dequeueReusableCell(withReuseIdentifier: "empty", for: indexPath) }
        switch item {
        case .groups(let detailedTableGroupsTitleCellVM):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailedTableGroupsTitleCell.identifier, for: indexPath) as? DetailedTableGroupsTitleCell else { return collectionView.dequeueReusableCell(withReuseIdentifier: "empty", for: indexPath) }
            cell.configure(detailedTableGroupsTitleCellVM)
            
            let isSelected = indexPath == selectedCellIndex
            UIView.animate(withDuration: 0.3) {
                cell.contentView.backgroundColor = isSelected ? UIColor.gray : UIColor(projColors: .gray)
            }
            return cell
        }
    }
}
