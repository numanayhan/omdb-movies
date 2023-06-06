//
//  Base.swift
//  Omdb Movies
//
//  Created by na on 5.06.2023.
//  Copyright © 2023 @ Numan Ayhan. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Alamofire

class Base: UIViewController {
    var statusBarStyle: UIStatusBarStyle = .default {
        didSet {
            UIView.animate(withDuration: 0.1) {
                self.setNeedsStatusBarAppearanceUpdate()
            }
        }
    }
    var isStatusBarHidden = false {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    var titleLabelText:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }

    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }

    override var prefersStatusBarHidden: Bool {
        return isStatusBarHidden
    }
    deinit {
        keyboardDoneButton(enabled: false)
//        removeNotificationsObserver()
    }
    func keyboardDoneButton(enabled: Bool) {
        IQKeyboardManager.shared.enableAutoToolbar = enabled ? true : false
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "OK"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        UIApplication.shared.statusBarStyle = .lightContent
        setNavbar()
//        setLayoutUI()
    }

    func setNavbar(){
        if navigationController != nil{
            navigationController?.navigationBar.isHidden = false
            navigationController?.setNavigationBarHidden(false, animated: true)

            self.navigationController?.navigationBar.backItem?.title = " "
            navigationController?.navigationBar.backgroundColor = .black
            self.navigationController?.navigationBar.backIndicatorImage = UIImage()
            self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage()
            self.navigationController!.navigationBar.tintColor  = .white
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
            self.navigationController?.navigationBar.prefersLargeTitles = true

            self.navigationItem.title = titleLabelText
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:  UIColor.white]

        }
    }
    func setLayoutUI(){
        view.backgroundColor = .black
    }
}
extension Base {
    var isInternetReachable: Bool {
        guard NetworkReachabilityManager()?.isReachable ?? false else {
            self.alertMessage(noInternetFriendlyMessage)
            return false
        }
        return true
    }

    func isInternetReachable(completion: ((Bool) -> Void)? = nil) {
        guard NetworkReachabilityManager()?.isReachable ?? false else {
            self.alertMessage(noInternetFriendlyMessage)
            return
        }
        completion?(true)
    }

    private var noInternetFriendlyMessage: AlertMessage {
        return AlertMessage(
            title: "connectionLostTitle",
            message: "connectionLost"
        )
    }
    func alertMessage(_ message:AlertMessage){
        let alert = UIAlertController(title: message.title, message: message.message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "İptal", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}

