//
//  GHUser.swift
//  GitHubUsers
//
//  Created by Oleksandr Asieiev on 9/14/16.
//  Copyright © 2016 Oleksandr Asieiev. All rights reserved.
//

class GHUser {
	
	private struct Constants {
		static let LoginKey = "login"
		static let ProfileLinkKey = "html_url"
		static let AvatarLinkKey = "avatar_url"
	}
	
	var userName: String!
	var profileLinkString: String!
	var avatarLinkString: String!
	
	init(JSONObject: Dictionary<String, AnyObject>) {
		guard let name = JSONObject[Constants.LoginKey] as? String else {
			assertionFailure("Cannot parse user object")
			return
		}
		userName = name
		
		guard let profile = JSONObject[Constants.ProfileLinkKey] as? String else {
			assertionFailure("Cannot parse user object")
			return
		}
		profileLinkString = profile
		
		guard let avatar = JSONObject[Constants.AvatarLinkKey] as? String else {
			assertionFailure("Cannot parse user object")
			return
		}
		avatarLinkString = avatar
	}
}
