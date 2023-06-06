//
//  AlertAction.swift
//  Omdb Movies
//
//  Created by na on 5.06.2023.
//  Copyright © 2023 @ Numan Ayhan. All rights reserved.
//

import Foundation
import UIKit

public class AlertAction: NSObject {
    public convenience init(
        title: String?,
        style: AlertAction.Style,
        handler: ((AlertAction) -> Void)? = nil
    ) {
        self.init()
        self.title = title
        self.style = style
        self.handler = handler
    }

    public convenience init(
        attributedTitle: NSAttributedString?,
        style: AlertAction.Style,
        handler: ((AlertAction) -> Void)? = nil
    ) {
        self.init()
        self.attributedTitle = attributedTitle
        self.style = style
        self.handler = handler
    }

    public var handler: ((AlertAction) -> Void)?

    private(set) public var title: String? {
        get { return self.attributedTitle?.string }
        set { self.attributedTitle = newValue.map(NSAttributedString.init) }
    }

    private(set) public var attributedTitle: NSAttributedString?

    internal(set) public var style: AlertAction.Style = .normal

    public var accessibilityIdentifier: String?
}

extension AlertAction {
    public enum Style: Int {
        /// The action will have default font and text color
        case normal
        /// The action will take a style that indicates it's the preferred option
        case preferred
        /// The action will convey that this action will do something destructive
        case destructive
    }
}
