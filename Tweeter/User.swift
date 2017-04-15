//
//  User.swift
//  Tweeter
//
//  Created by Rui Mao on 4/13/17.
//  Copyright © 2017 Rui Mao. All rights reserved.
//

import UIKit

class User: NSObject {
    var name : NSString?
    var screenname: NSString?
    var profileUrl: NSURL?
    var tagline: NSString?
    
    init(dictionary: NSDictionary) {

        name = dictionary["name"] as? String as NSString?
        screenname = dictionary["screen_name"] as? String as NSString?
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if profileUrlString == profileUrlString {
            profileUrl = NSURL(string: profileUrlString!)
        }
        tagline = dictionary["description"] as? String as NSString?
    }

    
}
