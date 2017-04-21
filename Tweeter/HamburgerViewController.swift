//
//  HamburgerViewController.swift
//  Tweeter
//
//  Created by Rui Mao on 4/20/17.
//  Copyright © 2017 Rui Mao. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController {

    @IBOutlet weak var leftMargin: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var menuView: UIView!
    
    var originalLeftMargin: CGFloat!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPanGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view)
        let velocity = sender.velocity(in: self.view)
        if sender.state == .began {
            originalLeftMargin = leftMargin.constant
            
        } else if sender.state == .changed{
            leftMargin.constant = originalLeftMargin + translation.x
            
        } else if sender.state == .ended {
            if velocity.x > 0 {
                leftMargin.constant = self.view.frame.size.width - 50
            } else {
                leftMargin.constant = 0
            }
            
        }
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
