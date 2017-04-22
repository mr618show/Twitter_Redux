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
    var headerUrl: NSURL?
    var tagline: NSString?
    var followersCount: Int = 0
    var followingCount: Int = 0
    
    var  dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary

        name = dictionary["name"] as? String as NSString?
        screenname = dictionary["screen_name"] as? String as NSString?
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if profileUrlString == profileUrlString {
            profileUrl = NSURL(string: profileUrlString!)
        }
        
        let headerUrlString = dictionary["profile_background_image_url_https"] as? String
        if headerUrlString == headerUrlString {
            headerUrl = NSURL(string: headerUrlString!)
        }
        
        
        tagline = dictionary["description"] as? String as NSString?
       followersCount = (dictionary["followers_count"] as? Int) ?? 0
       followingCount = (dictionary["friends_count"] as? Int) ?? 0
    
    }
    static var _currentUser: User?
    static let userDidLogoutNotification = "UserDidLogout"
    class var currentUser: User? {
        get {
            if _currentUser == nil {
            let defaults = UserDefaults.standard
            let userData = defaults.object(forKey: "currentUserData") as? NSData
            if let userData = userData {
                let dictionary = try!
                JSONSerialization.jsonObject(with: userData as Data, options: []) as! NSDictionary
                _currentUser = User(dictionary: dictionary)
            }
        }
            return _currentUser
        }
        
        
        set(user) {
            _currentUser = user
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
            defaults.synchronize()
        }
    }

    
}
