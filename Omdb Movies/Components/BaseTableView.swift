//
//  BaseTableView.swift
//  Omdb Movies
//
//  Created by na on 6.06.2023.
//  Copyright © 2023 @ Numan Ayhan. All rights reserved.
//

import UIKit
import TinyConstraints
import SnapKit

protocol BaseTableViewDelegate: AnyObject {
    func didSelect(index: Int)
}

class BaseTableView: UIView {

    weak var delegate: BaseTableViewDelegate?
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

    lazy var tableView:UITableView = {
        let tv = UITableView()
        return tv 
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func refresh() {
        guard let data = data else { return }
        labelTitle.text = data.title
        tableView.backgroundColor = .clear
        tableView.backgroundView = nil
    }
    
    fileprivate func configureView(){

        addSubview(labelTitle)
        labelTitle.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(10)
            make.width.equalToSuperview()
            make.height.equalTo(40)
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchCell.self, forCellReuseIdentifier: "SearchCell")
        tableView.rowHeight = 250
        addSubview(tableView)
        tableView.anchor(top: labelTitle.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: frame.width, height: 240)
        tableView.reloadData()
    }
}
extension BaseTableView : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.numberOfItems ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? SearchCell {
            guard let vm = data?.lists?[indexPath.row] else {
                return cell
            } 
            cell.data = vm
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
