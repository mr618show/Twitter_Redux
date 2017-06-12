//
//  ProfileHeader.swift
//  Tweeter
//
//  Created by Rui Mao on 6/11/17.
//  Copyright © 2017 Rui Mao. All rights reserved.
//

import UIKit

class ProfileHeader: UIView {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tagLine: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    
    var user: User! {
        didSet {
            userNameLabel.text = user.name as String?
            screenNameLabel.text = "@\((user.screenname)!)"
            tagLine.text = user.tagline as String?
            followersLabel.text = String(user.followersCount)
            followingLabel.text = String(user.followingCount)
            if let profileUrlString = user.profileUrl {
                profileImageView.setImageWith(profileUrlString as URL)
            }
        }
    }
    
 
}
