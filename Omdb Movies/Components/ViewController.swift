//
//  ViewController.swift
//  Omdb Movies
//
//  Created by na on 5.06.2023.
//  Copyright © 2023 @ Numan Ayhan. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    func showAlert(
        alertMessage: AlertMessage,
        image: UIImage? = nil,
        shouldDismissHandler: ((AlertAction?) -> Bool)? = nil,
        selectedActionHandler: ((AlertAction) -> Void)? = nil,
        selectedActionCompletionHandler: ((AlertAction) -> Void)? = nil,
        shoulDismissOnOutsideTap: Bool = true,
        outsideTapHandler: (() -> Void)? = nil
    ) {
        DispatchQueue.main.async {
//            AlertView.alert(friendlyMessage: alertMessage)
//            (
//                from: self,
//                friendlyMessage: alertMessage,
//                image: image,
//                shouldDismissHandler: shouldDismissHandler,
//                selectedActionHandler: selectedActionHandler,
//                selectedActionCompletionHandler: selectedActionCompletionHandler,
//                shoulDismissOnOutsideTap: shoulDismissOnOutsideTap,
//                outsideTapHandler: outsideTapHandler
//            )
        }
    }
}
