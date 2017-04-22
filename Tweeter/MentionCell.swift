//
//  MentionCell.swift
//  Tweeter
//
//  Created by Rui Mao on 4/22/17.
//  Copyright © 2017 Rui Mao. All rights reserved.
//

import UIKit

class MentionCell: UITableViewCell {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    
    
    var tweet: Tweet! {
        didSet {
            nameLabel.text = tweet.name as String?
            screenNameLabel.text = String("@")! + (tweet.screenname as String?)!
            self.thumbImageView.setImageWith(tweet.profileUrl as! URL)
            tweetLabel.text = tweet.text as String?
            let date = Date()
            let difference = date.timeIntervalSince(tweet.timestamp!)
            if (difference > 24 * 60 * 60) {
                let formatter = DateFormatter()
                // initially set the format based on your datepicker date
                formatter.dateFormat = "MM/dd/yy"
                timeStampLabel.text = formatter.string(from: tweet.timestamp!)
            }
            else if (difference >= 3600){
                timeStampLabel.text = String(Int(round(difference / 3600))) + "h"
            }
            else {
                timeStampLabel.text = String(Int(round(difference / 60))) + "m"
            }
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

    @IBAction func onReplyButton(_ sender: UIButton) {
    }
    @IBAction func onRetweetButton(_ sender: UIButton) {
    }
    @IBAction func onFavButton(_ sender: UIButton) {
    }
    
    
    
}
