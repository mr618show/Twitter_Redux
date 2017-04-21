//
//  MenuViewController.swift
//  Tweeter
//
//  Created by Rui Mao on 4/20/17.
//  Copyright © 2017 Rui Mao. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var navControllers: [UINavigationController] = []
    var menuSections = ["Profile", "Timeline", "Mentions"]
    let twitterColor = UIColor(red: 29/256, green: 202/256, blue: 255/256, alpha: 1.0)
    @IBOutlet weak var tableView: UITableView!
    var hamburgerController: HamburgerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.backgroundColor = twitterColor

        // Do any additional setup after loading the view.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tweetsNavController = storyboard.instantiateViewController(withIdentifier: "TweetsNC") as! UINavigationController
        let profileNavController = storyboard.instantiateViewController(withIdentifier: "ProfileNC") as! UINavigationController
        let mentionsNavController = storyboard.instantiateViewController(withIdentifier: "MentionsNC") as! UINavigationController
        
        navControllers.append(tweetsNavController)
        navControllers.append(profileNavController)
        navControllers.append(mentionsNavController)
        //hamburgerController.contentController = tweetsNavController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)
        cell.backgroundColor = twitterColor
        cell.textLabel?.text = menuSections[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
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
