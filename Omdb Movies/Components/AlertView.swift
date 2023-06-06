//
//  AlertView.swift
//  Omdb Movies
//
//  Created by na on 5.06.2023.
//  Copyright © 2023 @ Numan Ayhan. All rights reserved.
//

import UIKit

final class AlertView{
    // MARK: Data
    public var shouldDismissHandler: ((AlertAction?) -> Bool)?
    public var actionTappedHandler: ((AlertAction) -> Void)?
    public var actionTappedCompletionHandler: ((AlertAction) -> Void)?
    public var outsideTapHandler: (() -> Void)?
    public var isOutsideTapEnabled = false

    public var image: UIImage?
    public var title: String?
    public var message: String?
    private var actions = [AlertAction]()

    
}

//extension AlertView {
//    public static func alert(
//        friendlyMessage: AlertMessage,
//        image: UIImage? = nil,
//        shouldDismissHandler: ((AlertAction?) -> Bool)? = nil,
//        selectedActionHandler: ((AlertAction) -> Void)? = nil,
//        selectedActionCompletionHandler: ((AlertAction) -> Void)? = nil,
//        shoulDismissOnOutsideTap: Bool = true,
//        outsideTapHandler: (() -> Void)? = nil
//    ) -> AlertView {
//        var actions: [AlertAction] = []
//
//        if let buttonNeutral = friendlyMessage.buttonNeutral, !buttonNeutral.isEmpty {
//            let action = AlertAction(title: buttonNeutral, style: .normal)
//            actions.append(action)
//        }
//        if let buttonNegative = friendlyMessage.buttonNegative, !buttonNegative.isEmpty {
//            let action = AlertAction(title: buttonNegative, style: .normal)
//            actions.append(action)
//        }
//        if let buttonPositive = friendlyMessage.buttonPositive, !buttonPositive.isEmpty {
//            let action = AlertAction(title: buttonPositive, style: .preferred)
//            actions.append(action)
//        }
//        if actions.isEmpty {
//            let action = AlertAction(title: "Tamam", style: .preferred)
//            actions.append(action)
//        }
//
//        let alert = AlertView.alert(
//            title: friendlyMessage.title,
//            message: friendlyMessage.message,
//            image: image,
//            status: friendlyMessage.status,
//            actions: actions,
//            shouldDismissHandler: shouldDismissHandler,
//            selectedActionHandler: selectedActionHandler,
//            selectedActionCompletionHandler: selectedActionCompletionHandler,
//            shoulDismissOnOutsideTap: shoulDismissOnOutsideTap,
//            outsideTapHandler: outsideTapHandler
//        )
//
//        return alert
//    }
//
//    public class func showAlert(
//        from vc: UIViewController? = nil,
//        friendlyMessage: AlertMessage,
//        image: UIImage? = nil,
//        shouldDismissHandler: ((AlertAction?) -> Bool)? = nil,
//        selectedActionHandler: ((AlertAction) -> Void)? = nil,
//        selectedActionCompletionHandler: ((AlertAction) -> Void)? = nil,
//        shoulDismissOnOutsideTap: Bool = true,
//        outsideTapHandler: (() -> Void)? = nil
//    ) {
//        AlertView.showAlert(
//            from: vc?.view,
//            friendlyMessage: friendlyMessage,
//            image: image,
//            shouldDismissHandler: shouldDismissHandler,
//            selectedActionHandler: selectedActionHandler,
//            selectedActionCompletionHandler: selectedActionCompletionHandler,
//            shoulDismissOnOutsideTap: shoulDismissOnOutsideTap,
//            outsideTapHandler: outsideTapHandler
//        )
//    }
//
//    public class func showAlert(
//        from view: UIView? = nil,
//        friendlyMessage: AlertMessage,
//        image: UIImage? = nil,
//        shouldDismissHandler: ((AlertAction?) -> Bool)? = nil,
//        selectedActionHandler: ((AlertAction) -> Void)? = nil,
//        selectedActionCompletionHandler: ((AlertAction) -> Void)? = nil,
//        shoulDismissOnOutsideTap: Bool = true,
//        outsideTapHandler: (() -> Void)? = nil
//    ) {
//        let alert = AlertView.alert(
//            friendlyMessage: friendlyMessage,
//            image: image,
//            shouldDismissHandler: shouldDismissHandler,
//            selectedActionHandler: selectedActionHandler,
//            selectedActionCompletionHandler: selectedActionCompletionHandler,
//            shoulDismissOnOutsideTap: shoulDismissOnOutsideTap,
//            outsideTapHandler: outsideTapHandler
//        )
//
//        guard let view = view ?? UIApplication.shared.keyWindow else { return }
//        view.addSubview(alert)
//        alert.fillToSuperview()
//        alert.configureAlertView()
//        alert.show()
//    }
//}
