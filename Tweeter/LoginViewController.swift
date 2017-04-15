//
//  LoginViewController.swift
//  Tweeter
//
//  Created by Rui Mao on 4/12/17.
//  Copyright © 2017 Rui Mao. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {
    
    let twitterbaseURL = NSURL(string: "https://api.twitter.com/")
    let twitterConsumerKey: String = "EVsXgH8SH0m35ctoPFkLfLRbo"
    let twitterConsumerSecret: String = "LazYtWibDQAfBRxc8TsfbS0SfGKDL62icKu4yvs7kwP8T4sVdd"

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
    @IBAction func onLoginButton(_ sender: AnyObject) {
        
        let twitterClient = BDBOAuth1SessionManager(baseURL: twitterbaseURL as URL!, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        twitterClient?.deauthorize()
   
        twitterClient?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: NSURL(string: "mytwitterdemo://oauth") as URL!, scope: nil, success: {
            
            (requestToken:BDBOAuth1Credential?) -> Void in
                print("got token! \(requestToken!.token!)")

            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")!
           
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)

        }, failure: {
            
            (error: Error?) -> Void in
            print("error: \(error?.localizedDescription) ")
        })
    }
}
