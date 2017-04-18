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
        TwitterClient.sharedInstance?.tweet(text: self.tweetContent.text!, success: {
            print ("post")
            self.dismiss(animated: true, completion: nil)
        }, failure: { (error: NSError) in
            print("error: \(error.localizedDescription)")
        })
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
