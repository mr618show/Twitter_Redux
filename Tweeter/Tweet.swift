//
//  Tweet.swift
//  Tweeter
//
//  Created by Rui Mao on 4/13/17.
//  Copyright © 2017 Rui Mao. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var name: NSString?
    var screenname: NSString?
    var id: NSString?
    var profileUrl: NSURL?
    var text: NSString?
    var timestamp: Date?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    
    init (dictionary: NSDictionary) {
        name = (dictionary["user"] as! NSDictionary)["name"] as? String as NSString?
        screenname = (dictionary["user"]as! NSDictionary)["screen_name"] as? String as NSString?
        let profileUrlString = (dictionary["user"]as! NSDictionary)["profile_image_url_https"] as? String
        if profileUrlString == profileUrlString {
            profileUrl = NSURL(string: profileUrlString!)
        }

        text = dictionary["text"] as? String as NSString?
        id = dictionary["id_str"] as? String as NSString?
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0
        
        let timestampString = dictionary["created_at"] as? String
        if let timestampString = timestampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampString) as Date?
        }
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        return tweets
    }
    

}
