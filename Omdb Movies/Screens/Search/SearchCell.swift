//
//  SearchCell.swift
//  Omdb Movies
//
//  Created by na on 6.06.2023.
//  Copyright © 2023 @ Numan Ayhan. All rights reserved.
//

import UIKit
import SnapKit
import TinyConstraints

class SearchCell: UITableViewCell {

    var data: MoviesResult? {
        didSet {
            refresh()
        }
    }

    lazy var poster:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.layer.cornerRadius = 8
        return iv
    }()

    lazy var titleLabel : UITextView = {
        let label = UITextView()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.isEditable = false
        label.textAlignment = .justified
        label.textColor = .white
        label.textContainerInset = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 12)
        label.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        label.sizeToFit()
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupViews() {

        backgroundColor = UIColor.black.withAlphaComponent(0.15)
        layer.cornerRadius = 10
        layer.masksToBounds = true

        poster.layer.cornerRadius = 5
        poster.layer.masksToBounds = true

        addSubview(poster)
        poster.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }

        poster.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(0)
            make.height.equalTo(60)
            make.width.equalToSuperview()
        }
    }
    private func refresh() {
        guard let data = data else { return }
        titleLabel.text =  data.title
        poster.downloaded(from: URL(string: data.poster ?? "")!, contentMode: .scaleAspectFill)
    }

}
