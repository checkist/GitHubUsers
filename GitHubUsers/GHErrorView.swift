//
//  GHErrorView.swift
//  GitHubUsers
//
//  Created by Oleksandr Asieiev on 9/15/16.
//  Copyright © 2016 Oleksandr Asieiev. All rights reserved.
//

import UIKit

protocol GHErrorViewDelegate: NSObjectProtocol {
	func errorViewRequiresToRetry(sender: GHErrorView)
}

class GHErrorView: UIView {
	
	@IBOutlet private var textLabel: UILabel!
	private weak var delegate: GHErrorViewDelegate!
	
	class func errorView(errorText: String, delegate: GHErrorViewDelegate) -> GHErrorView {
		let result = NSBundle.mainBundle().loadNibNamed("GHErrorView", owner: self, options: nil).first as! GHErrorView
		result.textLabel.text = errorText;
		result.delegate = delegate
		return result
	}
	
	@IBAction func retry(sender: UIButton) {
		delegate.errorViewRequiresToRetry(self)
	}

}
