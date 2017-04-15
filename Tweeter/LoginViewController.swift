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
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginButton(_ sender: AnyObject) {
        TwitterClient.sharedInstance?.login(success: { () -> () in
            //print ("I've logged in!")
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        }) { (error: NSError) -> () in
          print("Error: \(error.localizedDescription)")
        }
       
}
}
