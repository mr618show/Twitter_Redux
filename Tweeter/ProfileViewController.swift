//
//  ProfileViewController.swift
//  Tweeter
//
//  Created by Rui Mao on 4/21/17.
//  Copyright © 2017 Rui Mao. All rights reserved.
//

import UIKit

let offset_HeaderStop:CGFloat = 120 - 64  // At this offset the Header stops its transformations
let distance_W_LabelHeader:CGFloat = 30.0 // The distance between the top of the screen and the top of the White Label

class ProfileViewController: TweetsViewController {

    @IBOutlet weak var blurImageView: UIImageView!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    
    @IBOutlet weak var headerBlurBackgroundHolder: UIImageView!

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    

    
    
    
    var user : User!
    var headerBlurImageView: UIImageView?
    var headerImageView: UIImageView?
    var isCurrentUser = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        headerLabel.isHidden = true
        if (user == nil) {
            user = User.currentUser
            self.headerLabel.text = user.name as String?
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
        profileImage.setImageWith(user!.profileUrl! as URL)
        if user.headerUrl != nil {
            headerImage.setImageWith(user!.headerUrl! as URL)
        }
        TwitterClient.sharedInstance?.userHomeTimeline(screenName: user.screenname as String!, success: {(tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        }, failure: { (error: NSError) -> () in
            print(error.localizedDescription)
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // HEADER UI:
        profileImage.layer.cornerRadius = 6
        profileImage.layer.cornerRadius = 4
        
        
        // Header - Image
        self.headerImageView = UIImageView(frame: self.headerView.bounds)
        
        self.headerImageView?.contentMode = .scaleAspectFill
        self.headerView.insertSubview(self.headerImageView!, belowSubview: self.headerLabel)
        
        // Header - Blurred Image Holder
       // self.headerBlurBackgroundHolder = UIImageView(frame: self.headerView.bounds)
        
        //self.headerBlurBackgroundHolder?.contentMode = .scaleAspectFill
        self.headerView.insertSubview(self.headerBlurBackgroundHolder!, belowSubview: self.headerLabel)
        
        // Header - Blurred Image
        self.headerBlurImageView = UIImageView(frame: self.headerView.bounds)
        headerBlurImageView?.alpha = 0.0
       /* if !isCurrentUser {
            self.headerImageView?.setImageWith(URL(string: tweet.backgroundImageUrl!)!)
            self.blurBackgroundHolder?.setImageWith(URL(string: tweet.backgroundImageUrl!)!)
            self.headerBlurImageView?.image = self.headerBlurBackgroundHolder?.image?.blurredImage(withRadius: 40, iterations: 20, tintColor: UIColor.clear)
        }
        */
        
        
        self.headerBlurImageView?.contentMode = .scaleAspectFill
        self.headerView.insertSubview(self.headerBlurImageView!, belowSubview: self.headerLabel)
        
        
        self.headerView.clipsToBounds = true
        
    }

    
    override func refreshControlAction(_ refreshControl: UIRefreshControl) {
        TwitterClient.sharedInstance?.userHomeTimeline(screenName: user.screenname as String!,success: {(tweets: [Tweet]) -> () in
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

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTweetCell", for: indexPath ) as! TweetCell
        cell.tweet = tweets[indexPath.row]
        return cell
    }
    
    // MARK: Scroll view delegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.y + headerView.bounds.height
        
        var avatarTransform = CATransform3DIdentity
        var headerTransform = CATransform3DIdentity
        
        // PULL DOWN -----------------
        
        if offset < 0 {
            
            let headerScaleFactor:CGFloat = -(offset) / headerView.bounds.height
            let headerSizevariation = ((headerView.bounds.height * (1.0 + headerScaleFactor)) - headerView.bounds.height)/2
            headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
            headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
            
            
            // Hide views if scrolled super fast
            headerView.layer.zPosition = 0
            headerLabel.isHidden = true
            
        }
            
            // SCROLL UP/DOWN ------------
            
        else {
            
            // Header -----------
            
            headerTransform = CATransform3DTranslate(headerTransform, 0, max(-offset_HeaderStop, -offset), 0)
            
            //  ------------ Label
            
            headerLabel.isHidden = false
            let alignToNameLabel = -offset + nameLabel.frame.origin.y + headerView.frame.height + offset_HeaderStop
            
            headerLabel.frame.origin = CGPoint(x: headerLabel.frame.origin.x, y: max(alignToNameLabel, distance_W_LabelHeader + offset_HeaderStop))
            
            
            //  ------------ Blur
            
            headerBlurBackgroundHolder?.alpha = min (1.0, (offset - alignToNameLabel)/distance_W_LabelHeader)
            
            // Avatar -----------
            
            let avatarScaleFactor = (min(offset_HeaderStop, offset)) / profileImage.bounds.height / 9.4 // Slow down the animation
            print(avatarScaleFactor)
            
            let avatarSizeVariation = ((profileImage.bounds.height * (1.0 + avatarScaleFactor)) - profileImage.bounds.height) / 2.0
            print(avatarSizeVariation)
            
            avatarTransform = CATransform3DTranslate(avatarTransform, 0, avatarSizeVariation, 0)
            avatarTransform = CATransform3DScale(avatarTransform, 1.0 - avatarScaleFactor, 1.0 - avatarScaleFactor, 0)
            
            if offset <= offset_HeaderStop {
                
                if profileImage.layer.zPosition < headerView.layer.zPosition{
                    headerView.layer.zPosition = 0
                }
                
                
            }else {
                if profileImage.layer.zPosition >= headerView.layer.zPosition{
                    headerView.layer.zPosition = 2
                }
                
            }
            
        }
        
        // Apply Transformations
        headerView.layer.transform = headerTransform
        profileImage.layer.transform = avatarTransform

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
