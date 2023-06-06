//
//  Launch.swift
//  Omdb Movies
//
//  Created by na on 5.06.2023.
//  Copyright © 2023 @ Numan Ayhan. All rights reserved.
//

import UIKit
import TinyConstraints

class Launch: Base {
    weak var timer: Timer?
    lazy var logoText : UILabel = {
        let label = UILabel()
        label.text = "Movies"
        label.font = UIFont.preferredFont(forTextStyle: .headline, compatibleWith: .none)
        label.textAlignment = NSTextAlignment.center
        label.textColor = .white
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setLayout()
        startTimer()
    }

    func setLayout() {
        view.addSubview(logoText)
        logoText.centerInSuperview()
        logoText.width(view.frame.width)
        logoText.height(90)
    }

    func startTimer() {
        _ = Timer.scheduledTimer(withTimeInterval: 1.66, repeats: false) {  _ in
            self.navigationController?.pushViewController(Search(), animated: true)
        } 
    }
}
