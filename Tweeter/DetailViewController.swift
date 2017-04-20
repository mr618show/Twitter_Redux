//
//  DetailViewController.swift
//  Tweeter
//
//  Created by Rui Mao on 4/16/17.
//  Copyright © 2017 Rui Mao. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetContentLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    @IBOutlet weak var replyText: UITextField!
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
    

    @IBAction func onReplyButton(_ sender: UIButton) {
        replyText.becomeFirstResponder()
    }
    @IBAction func onRetweetButton(_ sender: UIButton) {
        TwitterClient.sharedInstance?.addRetweet(id: tweet.id! as String!, success: {
            self.retweetCountLabel.text = "\(self.tweet.retweetCount + 1)"
            
        }, failure: { (error: NSError) in
            print ("error: \(error.localizedDescription)")
        })
    }
    @IBAction func onFavButton(_ sender: UIButton) {
        TwitterClient.sharedInstance?.addRetweet(id: tweet.id! as String!, success: {
            self.favoriteCountLabel.text = "\(self.tweet.favoritesCount + 1)"
            
        }, failure: { (error: NSError) in
            print ("error: \(error.localizedDescription)")
        })
    }
    
    // Start Editing The Text Field
    func textFieldDidBeginEditing(_ replyText: UITextField) {
        moveTextField(replyText, moveDistance: -260, up: true)
    }
    
    // Finish Editing The Text Field
    func textFieldDidEndEditing(_ replyText: UITextField) {
        moveTextField(replyText, moveDistance: -260, up: false)
    }
    
    // Hide the keyboard when the return key pressed
    func textFieldShouldReturn(_ replyText: UITextField) -> Bool {
        replyText.resignFirstResponder()
        return true
    }
    
    // Move the text field in a pretty animation!
    func moveTextField(_ replyText: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if textField == replyText {
            textField.resignFirstResponder()
            TwitterClient.sharedInstance?.tweet(text: self.replyText.text!, success: {
                print ("post")
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error: NSError) in
                print("error: \(error.localizedDescription)")
            })
            return false
        }
        return true
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
