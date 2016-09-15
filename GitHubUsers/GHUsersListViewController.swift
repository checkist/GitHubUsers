//
//  ViewController.swift
//  GitHubUsers
//
//  Created by Oleksandr Asieiev on 9/14/16.
//  Copyright © 2016 Oleksandr Asieiev. All rights reserved.
//

import UIKit

class GHUsersListViewController: GHLoadingViewController {
	
	struct Constants {
		static let cellIdentifier = "GHUserTableViewCell"
		static let loadFireCellIndex = 8
	}
	
	private var userName: String?
	private var nextURLLink: String?
	private var users: Array<GHUser>?
	private var selectedUser: GHUser?
	private var lastError: NSError?
	
	@IBOutlet private var tableView: UITableView!
	
	func update(user: GHUser) {
		userName = user.userName
		title = "\(user.userName)'s followers"
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.estimatedRowHeight = 100
		tableView.rowHeight = UITableViewAutomaticDimension
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		if users == nil {
			self.showLoadingOverlay()
			self.load()
		}
	}
	
	override func load() {
		lastError = nil
		GHUsersManager.shared.requstUsers(userName, nextURLString: nextURLLink) { [weak self] (users, nextURLString, error) in
			guard let users = users where error == nil else {
				if self?.users == nil {
					self?.showErrorView("Failed to load GitHub users")
				} else {
					self?.lastError = error
					self?.tableView.reloadData()
				}
				return
			}
			if self?.users == nil {
				self?.users = users
			} else {
				self?.users!.appendContentsOf(users)
			}
			self?.nextURLLink = nextURLString
			self?.hideLoadingOverlay()
			if self?.users!.count > 0 {
				self?.tableView.reloadData()
			} else {
				self?.showNoDataView()
			}
		}
	}
}

extension GHUsersListViewController: UITableViewDelegate, UITableViewDataSource {
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let result: Int
		if let users = users {
			result = users.count + (nextURLLink != nil ? 1 : 0)
		} else {
			result = 0
		}
		return result
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let result: UITableViewCell
		if indexPath.row == users?.count {
			let cell = tableView.dequeueReusableCellWithIdentifier("GHLoadingTableViewCell", forIndexPath: indexPath) as! GHLoadingTableViewCell
			if lastError == nil {
				cell.update(.Loading, delegate: self)
			} else {
				cell.update(.Error, delegate: self)
			}
			result = cell
		} else {
			let cell = tableView.dequeueReusableCellWithIdentifier(Constants.cellIdentifier, forIndexPath: indexPath) as! GHUserTableViewCell
			if let users = users {
				cell.update(users[indexPath.row])
			}
			result = cell
		}
		return result
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
		guard let users = users, let usersController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("GHUsersListViewController") as? GHUsersListViewController else {
			return
		}
		usersController.update(users[indexPath.row])
		navigationController?.pushViewController(usersController, animated: true)
	}
	
	func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
		guard let users = users, let _ = nextURLLink else {
			return
		}
		
		if indexPath.row == users.count - (1 + Constants.loadFireCellIndex) {
			if lastError == nil {
				self.load()
			}
		}
	}
}

extension GHUsersListViewController: GHLoadingTableViewCellDelegate {
	func loadingCellRequiresToRetry(sender: GHLoadingTableViewCell) {
		self.load()
		tableView.reloadData()
	}
}

