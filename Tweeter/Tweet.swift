//
//  Tweet.swift
//  Tweeter
//
//  Created by Rui Mao on 4/13/17.
//  Copyright © 2017 Rui Mao. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var text: NSString?
    var timestamp: Date?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    
    init (dictionary: NSDictionary) {
        text = dictionary["text"] as? String as NSString?
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorites_count"] as? Int) ?? 0
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
