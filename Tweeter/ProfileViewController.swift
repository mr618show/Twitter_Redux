//
//  ProfileViewController.swift
//  Tweeter
//
//  Created by Rui Mao on 4/21/17.
//  Copyright © 2017 Rui Mao. All rights reserved.
//

import UIKit

class ProfileViewController: TweetsViewController {

 
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!

    var user : User!
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
        
        self.title = user?.name as String?
        self.nameLabel.text = user?.name as String?
        
        if let screenName = user?.screenname {
            self.screenNameLabel.text = "@ \(screenName)"
        }
        if let followers = user?.followersCount {
            self.followerCountLabel.text = "\(followers)"
        }
        if let friends = user?.followingCount{
            followingCountLabel.text = "\(friends)"
        }
        
        profileImage.setImageWith(user!.profileUrl as! URL)
        if user.headerUrl != nil {
            headerImage.setImageWith(user!.headerUrl as! URL)
        }
        TwitterClient.sharedInstance?.userHomeTimeline(screenName: user.screenname as String!, success: {(tweets: [Tweet]) -> () in
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
