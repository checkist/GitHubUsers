//
//  GHLoadingOverlayView.swift
//  GitHubUsers
//
//  Created by Oleksandr Asieiev on 9/15/16.
//  Copyright © 2016 Oleksandr Asieiev. All rights reserved.
//

import UIKit

class GHLoadingOverlayView: UIView {

	class func loadingOverlay() -> GHLoadingOverlayView {
		return NSBundle.mainBundle().loadNibNamed("GHLoadingOverlayView", owner: self, options: nil).first as! GHLoadingOverlayView
	}

}
