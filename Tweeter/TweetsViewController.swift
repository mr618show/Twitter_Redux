//
//  TweetsViewController.swift
//  Tweeter
//
//  Created by Rui Mao on 4/15/17.
//  Copyright © 2017 Rui Mao. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var tweets = [Tweet]()

    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
    
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
        
        TwitterClient.sharedInstance?.homeTimeline(success: {(tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        }, failure: { (error: NSError) -> () in
            print(error.localizedDescription)
        })

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath ) as! TweetCell
         cell.tweet = tweets[indexPath.row]
         //cell.user = user
        return cell
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 
    }
    
    @IBAction func onLogoutButton(_ sender: Any) {
        TwitterClient.sharedInstance?.logout()
        
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
