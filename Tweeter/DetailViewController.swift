//
//  DetailViewController.swift
//  Tweeter
//
//  Created by Rui Mao on 4/16/17.
//  Copyright © 2017 Rui Mao. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetContentLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    var tweet: Tweet!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let name = tweet.name as? String
        self.nameLabel.text = name
        let screenname = tweet.screenname as? String
        self.screenNameLabel.text = screenname
        let content = tweet.text as? String
        self.tweetContentLabel.text = content
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yy, h:mm a"
        self.timestampLabel.text = formatter.string(from: tweet.timestamp!)
        

        let retweetCount = String(tweet.retweetCount)
        self.retweetCountLabel.text = retweetCount
        let favoritesCount = String(tweet.favoritesCount)
        self.favoriteCountLabel.text = favoritesCount
        thumbImageView.setImageWith(tweet.profileUrl as! URL)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
