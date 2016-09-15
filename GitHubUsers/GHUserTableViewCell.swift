//
//  GHUserTableViewCell.swift
//  GitHubUsers
//
//  Created by Oleksandr Asieiev on 9/14/16.
//  Copyright © 2016 Oleksandr Asieiev. All rights reserved.
//

import UIKit

class GHUserTableViewCell: UITableViewCell {

	@IBOutlet private var userNameLabel: UILabel!
	@IBOutlet private var profileLinkLabel: UILabel!
	@IBOutlet private var avatarImageView: UIImageView!
	
	func update(user: GHUser) {
		userNameLabel.text = user.userName
		profileLinkLabel.text = user.profileLinkString
		avatarImageView.setImageWithURL(NSURL(string: user.avatarLinkString)!, placeholderImage: UIImage(named: "defaultImage"))
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		avatarImageView.image = UIImage(named: "defaultImage")
	}
}
