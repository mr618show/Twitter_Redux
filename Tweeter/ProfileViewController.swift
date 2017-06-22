//
//  ProfileViewController.swift
//  Tweeter
//
//  Created by Rui Mao on 4/21/17.
//  Copyright © 2017 Rui Mao. All rights reserved.
//

import UIKit

class ProfileViewController: TweetsViewController{
    var user : User!
    var headerView: ProfileHeader!
    var scrollView: UIScrollView!
    var pageControl: UIPageControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120

        updateTimeline()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        headerView = Bundle.main.loadNibNamed("ProfileHeaderView", owner: self, options: nil)?[0] as! ProfileHeader
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: headerView.frame.width, height: headerView.frame.height))
        pageControl = UIPageControl(frame: CGRect(x: headerView.frame.width/2 - 78, y: 20, width: 100, height: 20))
        scrollView.delegate = self
        headerView.user = user
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = UIView()
        configPageControl()
    
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
    }
    
    func configPageControl() {
        pageControl.numberOfPages = 3
        pageControl.pageIndicatorTintColor = UIColor.gray
        pageControl.currentPageIndicatorTintColor = UIColor.black
        headerView.addSubview(pageControl)
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

}
