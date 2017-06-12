//
//  ProfileViewController.swift
//  Tweeter
//
//  Created by Rui Mao on 4/21/17.
//  Copyright © 2017 Rui Mao. All rights reserved.
//

import UIKit

class ProfileViewController: TweetsViewController {
    var user : User!
    var headerView: ProfileHeader!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120

        if (user == nil) {
            user = User.currentUser
            self.title = user.name as String?
        }
        updateTimeline()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        headerView = Bundle.main.loadNibNamed("ProfileHeaderView", owner: self, options: nil)?[0] as! ProfileHeader
        headerView.user = user
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = UIView()
        
  
        
        if let background = user.headerUrl {
            let image = UIImageView()
            image.setImageWith(background as URL)
            tableView.backgroundView = image
            tableView.backgroundView?.contentMode = .scaleAspectFill
            tableView.backgroundView?.clipsToBounds = true
            overlay.frame = tableView.frame
        }

        
     
        self.tableView.contentInset = defaultOffset
        originalTransform = self.tableView.backgroundView?.transform
        originalOverlayEffect = self.overlay.effect
        tableView.reloadData()
        /*TwitterClient.sharedInstance?.userHomeTimeline(screenName: user.screenname as String!, success: {(tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        }, failure: { (error: NSError) -> () in
            print(error.localizedDescription)
        }) */
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func updateTimeline() {
        if user == nil {
            
            user = User.currentUser
            TwitterClient.sharedInstance?.homeTimeline(success: {(tweets: [Tweet]) -> () in
                self.tweets = tweets
                self.tableView.reloadData()
            }, failure: { (error: NSError) -> () in
                print(error.localizedDescription)
            })
        }
        else {
            TwitterClient.sharedInstance?.userHomeTimeline(screenName: user.screenname! as String, success: {(tweets: [Tweet]) -> () in
                self.tweets = tweets
                self.tableView.reloadData()
            }, failure: { (error: NSError) -> () in
                print(error.localizedDescription)
            })
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTweetCell", for: indexPath ) as! TweetCell
        cell.tweet = tweets[indexPath.row]
        //cell.user = user
        return cell
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
