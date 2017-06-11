//
//  TweetsViewController.swift
//  Tweeter
//
//  Created by Rui Mao on 4/15/17.
//  Copyright © 2017 Rui Mao. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate , UIGestureRecognizerDelegate {
    var tweets = [Tweet]()
    var refreshControl: UIRefreshControl!
    let overlay = UIVisualEffectView()
    let defaultOffset = UIEdgeInsetsMake(60, 0, 0, 0)
    var originalOverlayEffect: UIVisualEffect!
    var originalTransform: CGAffineTransform!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
    
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        updateTimeline()
        //update background image
        
    }

    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        
        updateTimeline()
        self.tableView.backgroundView?.transform = CGAffineTransform(scaleX: 2, y: 2)
        UIView.animate(withDuration: 1) { 
            self.overlay.effect = UIBlurEffect(style: .extraLight)
            self.tableView.backgroundView?.transform = self.originalTransform
        }
        self.overlay.effect = originalOverlayEffect
        refreshControl.endRefreshing()
    }
    
    func updateTimeline() {
        TwitterClient.sharedInstance?.homeTimeline(success: {(tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        }, failure: { (error: NSError) -> () in
            print(error.localizedDescription)
        })
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
