//
//  TweetCell.swift
//  Tweeter
//
//  Created by Rui Mao on 4/15/17.
//  Copyright © 2017 Rui Mao. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetContentLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var thumbImageView: UIImageView!
    
    var tweet: Tweet! {
        didSet {
            tweetContentLabel.text = tweet.text as String?
            let date = Date()
            let difference = date.timeIntervalSince(tweet.timestamp!)
            if (difference > 24 * 60 * 60) {
                let formatter = DateFormatter()
                // initially set the format based on your datepicker date
                formatter.dateFormat = "MM/dd/yy"
                timestampLabel.text = formatter.string(from: tweet.timestamp!)
            }
            else if (difference >= 3600){
                timestampLabel.text = String(Int(round(difference / 3600))) + "h"
            }
            else {
                timestampLabel.text = String(Int(round(difference / 60))) + "m"
            }
            
        }
    }
    
    var user: User! {
        willSet {
            nameLabel.text = user.name as String?
            screenNameLabel.text = user.screenname as String?
            self.thumbImageView.setImageWith(user.profileUrl as! URL)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
