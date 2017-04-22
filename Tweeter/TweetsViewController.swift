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
    var refreshControl: UIRefreshControl!

    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
    
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        //Setting Nav bar color
        let twitterColor = UIColor(red: 29/256, green: 202/256, blue: 255/256, alpha: 1.0)
        navigationController?.navigationBar.barTintColor = twitterColor
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        //pull to refresh
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        //retrieve tweets
        TwitterClient.sharedInstance?.homeTimeline(success: {(tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        }, failure: { (error: NSError) -> () in
            print(error.localizedDescription)
        })
        
        // Do any additional setup after loading the view.
    }

func refreshControlAction(_ refreshControl: UIRefreshControl) {
    
    TwitterClient.sharedInstance?.homeTimeline(success: {(tweets: [Tweet]) -> () in

        self.tweets = tweets
        for tweet in tweets {
            print (tweet)
        }
        self.tableView.reloadData()
    }, failure: { (error: NSError) -> () in
        print(error.localizedDescription)
    })
    refreshControl.endRefreshing()
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


    
    @IBAction func onLogoutButton(_ sender: UIBarButtonItem) {
        TwitterClient.sharedInstance?.logout()
        
    }
    
    @IBAction func onNewButton(_ sender: UIBarButtonItem) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let composeVC = mainStoryboard.instantiateViewController(withIdentifier: "ComposeVC") as! ComposeViewController
        self.present(composeVC, animated: true, completion: nil)
        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is DetailViewController {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)
        let tweet = tweets[indexPath!.row]
        let detailViewController = segue.destination as! DetailViewController
        detailViewController.tweet = tweet
        }
        
    }
    

}
