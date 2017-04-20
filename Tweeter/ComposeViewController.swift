//
//  ComposeViewController.swift
//  Tweeter
//
//  Created by Rui Mao on 4/16/17.
//  Copyright © 2017 Rui Mao. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    @IBOutlet weak var thumImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetContent: UITextField!
    
    @IBOutlet weak var countDownLabel: UILabel!
    var isReply: Bool = false
    var tweetID: Int?
    var replyTo: String?
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        //Setting Nav bar color
        let twitterColor = UIColor(red: 29/256, green: 202/256, blue: 255/256, alpha: 1.0)
        navigationController?.navigationBar.barTintColor = twitterColor
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        self.nameLabel.text = User.currentUser?.name as String?
        thumImageView.setImageWith(User.currentUser!.profileUrl as! URL)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancelButton(_ sender: UIBarButtonItem) {
         self.dismiss(animated: true, completion: nil)
    }

    @IBAction func onTweetButton(_ sender: UIBarButtonItem) {
        if let text = tweetContent.text {
            if isReply {
                TwitterClient.sharedInstance?.replyTweet(
                    tweet: text,
                    tweetID: tweetID!,
                    success: { newTweet in
                        self.dismiss(animated: true, completion: nil)
                        
                }, failure: { error in
                    print("error: \(error.localizedDescription)")
                })
                
            }else {
                TwitterClient.sharedInstance?.tweet(text: self.tweetContent.text!, success: {
                    print ("posted!")
                    self.dismiss(animated: true, completion: nil)
                }, failure: { (error: NSError) in
                    print("error: \(error.localizedDescription)")
                })
            }
        }
    }
    
    
}



