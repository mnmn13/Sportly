//
//  DetailedLatestResultsCell.swift
//  Sportly
//
//  Created by MN on 21.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

class DetailedLatestResultsCell: UITableViewCell {
    
    static let identifier = String(describing: DetailedLatestResultsCell.self)
    
    private var viewModel: DetailedLatestResultsCellVM?
    
    // MARK: - CollectionView
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .infinite, collectionViewLayout: mainSectionLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        registerCells(collectionView)
        return collectionView
    }()
    
    // MARK: - PageControl
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor(projColors: .gray)
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.hidesForSinglePage = true
        pageControl.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UICollectionViewCompositionalLayout
    private func mainSectionLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 0, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .estimated(400))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        pageContolTransitions(section)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 40)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    // MARK: - Configure PageControl transitions
    private func pageContolTransitions(_ section: NSCollectionLayoutSection) {
        section.visibleItemsInvalidationHandler = { [weak self] items, offset, env in
            guard let self = self else { return }
            let page = round(offset.x / contentView.bounds.width * 2.6)
            self.pageControl.currentPage = Int(page)
        }
    }
    
    // MARK: - Register cells
    private func registerCells(_ collectionView: UICollectionView) {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "empty")
        collectionView.register(DetailedLatestResultsCVCell.self, forCellWithReuseIdentifier: DetailedLatestResultsCVCell.identifier)
    }
    
    // MARK: - Configure
    func configure(_ viewModel: DetailedLatestResultsCellVM) {
        self.viewModel = viewModel
        configureContent()
    }
    
    // MARK: - Constraints
    private func setupConstraints() {
        contentView.addSubview(collectionView)
        contentView.addSubview(pageControl)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(180)
        }
        
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.centerX.equalTo(collectionView)
        }
    }
    
    // MARK: - Configure content
    private func configureContent() {
        pageControl.numberOfPages = viewModel?.getNumberIfItems() ?? 0
    }
}

// MARK: - UICollectionViewDelegate
extension DetailedLatestResultsCell: UICollectionViewDelegate {}

// MARK: - UICollectionViewDataSource
extension DetailedLatestResultsCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.getNumberIfItems() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = viewModel?.getItem(indexPath) else { return collectionView.dequeueReusableCell(withReuseIdentifier: "empty", for: indexPath) }
        
        switch item {
        case .unitedContentCells(let detailedLatestResultsCVCellVM):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailedLatestResultsCVCell.identifier, for: indexPath) as? DetailedLatestResultsCVCell else { return collectionView.dequeueReusableCell(withReuseIdentifier: "empty", for: indexPath) }
            cell.configure(detailedLatestResultsCVCellVM)
            return cell
        }
    }
}
