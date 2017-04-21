//
//  ComposeViewController.swift
//  Tweeter
//
//  Created by Rui Mao on 4/16/17.
//  Copyright © 2017 Rui Mao. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var thumImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UITextView!
    @IBOutlet weak var countDownLabel: UILabel!
    
    var isReply: Bool = false
    var tweetID: Int?
    var replyTo: String?
    override func viewDidLoad() {
    
        super.viewDidLoad()
        self.countDownLabel.text = "140"
        self.tweetContent.delegate = self
        self.updateCharacterCount()
        
        
        //Setting Nav bar color
        let twitterColor = UIColor(red: 29/256, green: 202/256, blue: 255/256, alpha: 1.0)
        if let navigationBar = self.navigationController?.navigationBar {
        navigationBar.barTintColor = twitterColor
        navigationBar.tintColor = UIColor.white
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        //add countDown lable in nav bar
            /*let countDownFrame = CGRect(x: (navigationBar.frame.width) * 5/8, y: 0, width: navigationBar.frame.width/2, height: navigationBar.frame.height)
            
            let countDownLabel = UILabel(frame: countDownFrame)
            countDownLabel.text = "140"
            navigationBar.addSubview(countDownLabel)
        */
        }
        
        
        self.nameLabel.text = User.currentUser?.name as String?
        self.screenNameLabel.text = String("@")! + (User.currentUser?.screenname as String?)!
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
    
    func updateCharacterCount() {
        
        self.countDownLabel.reloadInputViews()
        self.countDownLabel.text = "\(140 - (self.tweetContent.text?.characters.count)!)"
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if 140 - (tweetContent.text?.characters.count)! < 20 {
            countDownLabel.textColor = UIColor.red
            if 140 - (tweetContent.text?.characters.count)! < 0 {
                self.navigationItem.rightBarButtonItem?.isEnabled = false
            }
        } else {
            countDownLabel.textColor = UIColor.gray
        }
        self.updateCharacterCount()
    }
}






