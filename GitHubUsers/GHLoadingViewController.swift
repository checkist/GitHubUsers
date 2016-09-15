//
//  GHLoadingViewController.swift
//  GitHubUsers
//
//  Created by Oleksandr Asieiev on 9/15/16.
//  Copyright © 2016 Oleksandr Asieiev. All rights reserved.
//

import UIKit

class GHLoadingViewController: UIViewController {

	private var loadingOverlay: GHLoadingOverlayView?
	private var errorView: GHErrorView?
	private var noDataView: GHNoDataView?
	
	func load() {
		assertionFailure("Do not call this method directly. Override in children")
	}
	
	func showLoadingOverlay() {
		loadingOverlay = GHLoadingOverlayView.loadingOverlay()
		view.addSubview(loadingOverlay!)
		self.addSameSizeConstraintsToView(loadingOverlay!)
	}
	
	func hideLoadingOverlay() {
		loadingOverlay?.removeFromSuperview()
		loadingOverlay = nil
	}
	
	func showErrorView(errorTitle: String) {
		errorView = GHErrorView.errorView(errorTitle, delegate: self)
		view.addSubview(errorView!)
		self.addSameSizeConstraintsToView(errorView!)
	}
	
	func hideErrorView() {
		errorView?.removeFromSuperview()
		errorView = nil
	}
	
	func showNoDataView() {
		noDataView = GHNoDataView.noDataView()
		view.addSubview(noDataView!)
		self.addSameSizeConstraintsToView(noDataView!)
	}
	
	func hideNoDataView() {
		noDataView?.removeFromSuperview()
		noDataView = nil
	}
}

extension GHLoadingViewController: GHErrorViewDelegate {
	func errorViewRequiresToRetry(sender: GHErrorView) {
		self.hideErrorView()
		self.load()
	}
}
