//
//  NavigationAppRoot.swift
//  Omdb Movies
//
//  Created by na on 5.06.2023.
//  Copyright © 2023 @ Numan Ayhan. All rights reserved.
//

import UIKit
public class DefaultNavigation: UINavigationController {
    var isDark = false {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
            UIApplication.shared.statusBarStyle = .lightContent
        }
    }
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return isDark ? .default : .lightContent
    }
}

class NavigationAppRoot {
    private let window : UIWindow?
    init(window: UIWindow ) {
        self.window = window
    }
    func startApp() {
//        let launch =
//        launch.isDark = false
        window!.rootViewController = DefaultNavigation(rootViewController: Launch())
        window!.makeKeyAndVisible()
    }

}
