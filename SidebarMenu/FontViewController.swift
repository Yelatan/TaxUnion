//
//  FontViewController.swift
//  SidebarMenu
//
//  Created by Bakbergen on 7/4/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import Foundation
class FontViewController: UIViewController{
    @IBOutlet var clientB: UIButton!
    @IBOutlet var notClientB: UIButton!
    @IBOutlet var regButton: UIBarButtonItem!
    
    @IBAction func clientButton(sender: AnyObject) {
//        let loginPageView =  self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
//        self.presentViewController(loginPageView, animated: true, completion: nil)
//        
//        var vc: UINavigationController//DetailMovieController!
//        vc = self.storyboard?.instantiateViewControllerWithIdentifier("nav") as! UINavigationController;
//        self.presentViewController(vc, animated: true, completion: nil)
//
        
        NSLog("oess")
    }
//
    
 
    
    override func viewDidLoad() {
        self.navigationController?.navigationBarHidden = true
//        if revealViewController() != nil {
//            regButton.target = revealViewController()
//            revealViewController().rearViewRevealWidth = 400
//            regButton.action = "RevealToggle:"
//            
////            revealViewController().rightViewRevealWidth = 200
////            sortButton.target = revealViewController()
////            sortButton.action = "rightRevealToggle:"
//            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
//        }
        
        
    }
}