//
//  GHUsersManager.swift
//  GitHubUsers
//
//  Created by Oleksandr Asieiev on 9/14/16.
//  Copyright © 2016 Oleksandr Asieiev. All rights reserved.
//

import UIKit

class GHUsersManager {
	
	private struct Constants {
		static let LinksHeaderKey = "Link"
		static let NextLinkRelKey = "rel=\"next\""
	}
	
	static let shared = GHUsersManager()
	
	private lazy var sessionManager = AFHTTPSessionManager(baseURL: nil)
	
	func requstUsers(userName: String?, nextURLString: String?, completion: (users: Array<GHUser>?, nextURLString: String?, error: NSError?) -> Void) {
		if let nextURLString = nextURLString {
			self.requestNextUsers(nextURLString, completion: completion)
		} else if let userName = userName {
			// requesting followers
			self.requestFollowers(userName, completion: completion)
		} else {
			// requesting all users
			self.requestAllUsers(completion)
		}
	}
	
	private func requestAllUsers(completion: (users: Array<GHUser>?, nextURLString: String?, error: NSError?) -> Void) {
		sessionManager.GET(GHURLFactory.shared.allUsersURLString(), parameters: nil, progress: nil, success: { [weak self] (task, responseObject) in
			completion(users: self?.usersFromResponse(responseObject), nextURLString: self?.nextURLFromResponse(task.response), error: nil)
			}) { [weak self] (task, error) in
			completion(users: nil, nextURLString: self?.nextURLFromResponse(task?.response), error: error)
		}
	}
	
	private func requestFollowers(userName: String, completion: (users: Array<GHUser>?, nextURLString: String?, error: NSError?) -> Void) {
		sessionManager.GET(GHURLFactory.shared.userFollowersURLString(userName), parameters: nil, progress: nil, success: { [weak self] (task, responseObject) in
			completion(users: self?.usersFromResponse(responseObject), nextURLString: self?.nextURLFromResponse(task.response), error: nil)
		}) { [weak self] (task, error) in
			completion(users: nil, nextURLString: self?.nextURLFromResponse(task?.response), error: error)
		}
	}
	
	private func requestNextUsers(nextURLString: String, completion: (users: Array<GHUser>?, nextURLString: String?, error: NSError?) -> Void) {
		sessionManager.GET(nextURLString, parameters: nil, progress: nil, success: { [weak self] (task, responseObject) in
			completion(users: self?.usersFromResponse(responseObject), nextURLString: self?.nextURLFromResponse(task.response), error: nil)
		}) { [weak self] (task, error) in
			completion(users: nil, nextURLString: self?.nextURLFromResponse(task?.response), error: error)
		}
	}
	
	private func usersFromResponse(response: AnyObject?) -> Array<GHUser>? {
		guard let response = response as? Array<Dictionary<String, AnyObject>> else {
			return nil
		}
		var users = Array<GHUser>()
		for JSONObject in response {
			users.append(GHUser(JSONObject: JSONObject))
		}
		return users
	}
	
	private func nextURLFromResponse(response: NSURLResponse?) -> String? {
		guard let response = response as? NSHTTPURLResponse else {
			return nil
		}
		
		guard let links = response.allHeaderFields[Constants.LinksHeaderKey] as? String else {
			return nil
		}
		var result: String? = nil
		let linkComponents = links.componentsSeparatedByString(", ")
		for linkComponent in linkComponents {
			if linkComponent.containsString(Constants.NextLinkRelKey) {
				result = linkComponent.componentsSeparatedByString("; ").first
				result = result?.stringByReplacingOccurrencesOfString("<", withString: "")
				result = result?.stringByReplacingOccurrencesOfString(">", withString: "")
				break
			}
		}
		return result
	}
}
