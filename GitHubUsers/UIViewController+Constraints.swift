//
//  GHViewController.swift
//  GitHubUsers
//
//  Created by Oleksandr Asieiev on 9/15/16.
//  Copyright © 2016 Oleksandr Asieiev. All rights reserved.
//

extension UIViewController {
	func addSameSizeConstraintsToView(view: UIView) {
		view.translatesAutoresizingMaskIntoConstraints = false
		self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[view]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view" : view]))
		self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[view]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view" : view]))
		self.view.layoutIfNeeded()
	}
}
