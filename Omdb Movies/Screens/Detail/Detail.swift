//
//  Detail.swift
//  Omdb Movies
//
//  Created by na on 6.06.2023.
//  Copyright © 2023 @ Numan Ayhan. All rights reserved.
//

import UIKit
import SnapKit
import TinyConstraints

class Detail: UIViewController {
    var data: MoviesResult? {
        didSet {
            refreshLayout()
        }
    }

    var indexSelected:Int = 0

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

    override func viewDidLoad() {
        super.viewDidLoad()

        setLayout()
        setNavbar()
    }
    
    func setLayout(){
        view.backgroundColor = .white
        poster.layer.cornerRadius = 5
        poster.layer.masksToBounds = true
        poster.backgroundColor = .red
        view.addSubview(poster)
        poster.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(100)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(300)
            make.width.equalTo(300)
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

    func refreshLayout(){
        guard let data = data else { return }
        titleLabel.text =  data.title
        let dataUrl = data.poster
        poster.downloaded(from: URL(string: dataUrl ?? "")!, contentMode: .scaleAspectFill)
    }
    
}
extension Detail {
    func setNavbar(){
        if navigationController != nil{
            navigationController?.navigationBar.isHidden = false
            navigationController?.setNavigationBarHidden(false, animated: true)
            navigationController?.navigationBar.backgroundColor = .white
            self.navigationController!.navigationBar.tintColor  = .black
            self.navigationItem.hidesBackButton = true
            self.navigationItem.backButtonTitle = "Back"
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"Back", style:.plain, target:nil, action:nil)
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationItem.title = "Detail"
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(addTapped))
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:  UIColor.black]
        }
    }
    @objc func addTapped(){
        self.navigationController?.popViewController(animated: true)
    }
}
