//
//  GHURLFactory.swift
//  GitHubUsers
//
//  Created by Oleksandr Asieiev on 9/14/16.
//  Copyright © 2016 Oleksandr Asieiev. All rights reserved.
//

class GHURLFactory {
	
	private  struct Constants {
		static let ResultsCountPerPage = 25
	}
	
	private  struct URLParameters {
		static let CountPerPage = "per_page="
	}
	
	private  struct URLTemplates {
		static let AllUsersURLTemplate = "https://api.github.com/users"
		static let FollowersURLTemplate = "https://api.github.com/users/%@/followers"
	}
	
	static let shared = GHURLFactory()
	
	func allUsersURLString() -> String {
		return String(format: URLTemplates.AllUsersURLTemplate + "?" + "%@" + "%d", URLParameters.CountPerPage, Constants.ResultsCountPerPage)
	}
	
	func userFollowersURLString(userName: String) -> String {
		return String(format: URLTemplates.FollowersURLTemplate + "?" + "%@" + "%d", userName, URLParameters.CountPerPage, Constants.ResultsCountPerPage)
	}
}
