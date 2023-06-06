//
//  BaseCollectionView.swift
//  Omdb Movies
//
//  Created by na on 5.06.2023.
//  Copyright © 2023 @ Numan Ayhan. All rights reserved.
//


import UIKit
import TinyConstraints
import SnapKit

protocol BaseCollectionViewDelegate: AnyObject {
    func didSelect(index: Int)
}
class BaseCollectionView: UIView {

    weak var delegate: BaseCollectionViewDelegate?
    var data: MoviesVM? {
        didSet {
            refresh()
        }
    }
    lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        label.sizeToFit()
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .left
        label.textColor = .black
        label.sizeToFit()
        return label
    }()

    lazy var collectionView:UICollectionView = {
        let cv = UICollectionView(frame: .zero,collectionViewLayout: UICollectionViewLayout())
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.isScrollEnabled = true
        cv.isUserInteractionEnabled = true
        cv.bounces = true
        return cv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCollectionView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let centeredCollectionViewFlowLayout = CenteredCollectionViewFlowLayout()
    let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        return layout
    }()
    let cellPercentWidth: CGFloat = 0.2
    private func configureCollectionView() {
        let layout = SnappingLayout()
        layout.snapPosition = .center
        layout.scrollDirection = .horizontal
        layout.itemSize = data?.size ?? CGSize()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(SearchMediaCell.self, forCellWithReuseIdentifier:  "SearchMediaCell")
        collectionView.isScrollEnabled = true
        
        addSubview(labelTitle)
        labelTitle.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.width.equalToSuperview()
            make.height.equalTo(60)
        }

        addSubview(collectionView)
        collectionView.anchor(top: labelTitle.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: frame.width, height: data?.size.height ?? 200)
    }
    private func refresh() {
        guard let data = data else { return }
        labelTitle.text = data.title
        collectionView.backgroundColor = .clear
        collectionView.backgroundView = nil
        backgroundColor = .clear
        self.collectionView.reloadData()
    }
}


// MARK: - UICollectionViewDelegate
extension BaseCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelect(index: indexPath.row)
    }
}

// MARK: - UICollectionViewDataSource
extension BaseCollectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
         return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.numberOfItems ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchMediaCell", for: indexPath) as? SearchMediaCell {
            guard let vm = data?.lists?[indexPath.row] else {
                return cell
            }
            cell.data = vm
            return cell
        }
        return UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension BaseCollectionView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return data?.size ?? .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return data?.sectionInset ?? .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return data?.minimumLineSpacing ?? .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return data?.minimumInteritemSpacing ?? .zero
    }
}
