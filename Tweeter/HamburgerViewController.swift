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
    var menuViewController: UIViewController! {
        didSet {
            view.layoutIfNeeded()
            menuView.addSubview(menuViewController.view)
        }
    }
    
    var contentViewController: UIViewController! {
        didSet(oldContentViewController) {
            view.layoutIfNeeded()
            if oldContentViewController != nil {
                oldContentViewController.willMove(toParentViewController: nil)
                oldContentViewController.view.removeFromSuperview()
                oldContentViewController.didMove(toParentViewController: nil)
            }
            
            contentViewController.willMove(toParentViewController: self)
            contentView.addSubview(contentViewController.view)
            contentViewController.didMove(toParentViewController: self)
            UIView.animate(withDuration: 0.3) {
                self.leftMargin.constant = 0
                self.view.layoutIfNeeded()
            }
        }
        
    }
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
            UIView.animate(withDuration: 0.3, animations: {
                if velocity.x > 0 {
            self.leftMargin.constant = self.originalLeftMargin + translation.x
                }
            })
        } else if sender.state == .ended {
            UIView.animate(withDuration: 0.3, animations: {
                if velocity.x > 0 {
                    self.leftMargin.constant = self.view.frame.size.width - 150
                } else {
                    self.leftMargin.constant = 0
                }
                self.view.layoutIfNeeded()
            })
            
            
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
