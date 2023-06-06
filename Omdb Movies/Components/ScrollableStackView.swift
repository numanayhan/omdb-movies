//
//  ScrollableStackView.swift
//  Omdb Movies
//
//  Created by na on 6.06.2023.
//  Copyright © 2023 @ Numan Ayhan. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
public class ScrollableStackView: UIView {

    fileprivate var didSetupConstraints = false
    @IBInspectable open var spacing: CGFloat = 8
    open var durationForAnimations:TimeInterval = 1.45

    public lazy var scrollView: UIScrollView = {
        let sv = UIScrollView(frame: CGRect.zero)
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.layoutMargins = .zero
        sv.isScrollEnabled = true
        sv.isUserInteractionEnabled = true
        sv.bounces = false
        sv.showsVerticalScrollIndicator =  false
        sv.showsHorizontalScrollIndicator =  false
        return sv
    }()

    public lazy var stackView: UIStackView = {
        let instance = UIStackView(frame: CGRect.zero)
        instance.translatesAutoresizingMaskIntoConstraints = false
        instance.axis = .vertical
        instance.spacing = self.spacing
        instance.distribution = .equalSpacing
        return instance
    }()
    var refreshControl = UIRefreshControl()
    // MARK: View life cycle
    override public func didMoveToSuperview() {
        super.didMoveToSuperview()

    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: UI
    func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        addSubview(scrollView)
        scrollView.addSubview(stackView)
//        setNeedsUpdateConstraints()
        setRefreshControl()
    }
    func setRefreshControl() {
        self.refreshControl.tintColor = UIColor.black
        self.refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
    }
    @objc func refresh() {

        self.refreshControl.endRefreshing()

    }
    override public func updateConstraints() {
        super.updateConstraints()

        if !didSetupConstraints {
            scrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true

            // Set the width of the stack view to the width of the scroll view for vertical scrolling
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

            didSetupConstraints = true
        }
    }
}
