//
//  AppDelegate.swift
//  Omdb Movies
//
//  Created by na on 5.06.2023.
//

import UIKit
var root : NavigationAppRoot?

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setNavigationApp()
        return true
    }

    func setNavigationApp(){
        window = UIWindow(frame: UIScreen.main.bounds)
        root = NavigationAppRoot(window: window!)
        root?.startApp()
    }

}

