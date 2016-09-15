//
//  GHNoDataView.swift
//  GitHubUsers
//
//  Created by Oleksandr Asieiev on 9/15/16.
//  Copyright © 2016 Oleksandr Asieiev. All rights reserved.
//

import UIKit

class GHNoDataView: UIView {

	class func noDataView() -> GHNoDataView {
		return NSBundle.mainBundle().loadNibNamed("GHNoDataView", owner: self, options: nil).first as! GHNoDataView
	}

}
