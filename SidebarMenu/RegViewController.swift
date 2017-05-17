//
//  RegViewController.swift
//  TaxUnion
//
//  Created by Bakbergen on 8/3/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class RegViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
//        let isUserLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("Logenter")
//        if(!isUserLoggedIn){
//            self.performSegueWithIdentifier("LView", sender: self)
//        print("isuserlog out")
//        }
    }
    
    @IBAction func LogoutButtonTapped(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "LogIn")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        self.performSegueWithIdentifier("LView", sender: self)
    }
}
