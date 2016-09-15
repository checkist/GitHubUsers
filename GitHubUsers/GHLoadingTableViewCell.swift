//
//  GHLoadingTableViewCell.swift
//  GitHubUsers
//
//  Created by Oleksandr Asieiev on 9/15/16.
//  Copyright © 2016 Oleksandr Asieiev. All rights reserved.
//

import UIKit

protocol GHLoadingTableViewCellDelegate: NSObjectProtocol {
	func loadingCellRequiresToRetry(sender: GHLoadingTableViewCell)
}

class GHLoadingTableViewCell: UITableViewCell {
	
	enum LoadingState {
		case Loading
		case Error
	}
	
	private weak var delegate: GHLoadingTableViewCellDelegate!
	
	@IBOutlet private var activityIndicator: UIActivityIndicatorView!
	@IBOutlet private var retryButton: UIButton!
	
	func update(state: LoadingState, delegate: GHLoadingTableViewCellDelegate) {
		self.delegate = delegate
		switch state {
		case .Loading:
			activityIndicator.startAnimating()
			retryButton.hidden = true
		case .Error:
			activityIndicator.stopAnimating()
			retryButton.hidden = false
		}
	}
	
	@IBAction func retry(sender: UIButton) {
		delegate.loadingCellRequiresToRetry(self)
	}

}
