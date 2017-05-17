//
//  PhotoViewController.swift
//  SidebarMenu
//
//  Created by Simon Ng on 2/2/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import UIKit
import SDWebImage


class GoodsforIPViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{
    var window : UIWindow?
    @IBOutlet var menuButton: UIBarButtonItem!
    @IBOutlet var goodsViews: UITextView!
    @IBOutlet var sortButton: UIBarButtonItem!
    var tableView: UITableView = UITableView()
    var buttonofG: UIButton = UIButton()
    var SaveData = SaveDataViewController.sharedInstance

    override func viewDidAppear(animated: Bool) {
        let isUserLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("Logenter")
        if(!isUserLoggedIn){
            self.performSegueWithIdentifier("GoodsLogOut", sender: self)
            print("isuserlog out")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (SaveData.arrayName.isEmpty){
        let pref = NSUserDefaults.standardUserDefaults()
        let tovars = pref.objectForKey("tovari") as? [[String: AnyObject]]
        print(tovars)
        for goods in tovars!{
            let name: String? = goods["name"] as? String
            SaveData.arrayName.append(name! as! String)
            SaveData.arrayPrice.append((goods["price"] as? String)!)
            SaveData.arrayImageUrl.append((goods["image"] as? String)!)
            SaveData.arrayDescription.append((goods["description"] as? String)!)
            }
        } 
//
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = "revealToggle:"
            
            revealViewController().rightViewRevealWidth = 200
            sortButton.target = revealViewController()
            sortButton.action = "rightRevealToggle:"
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        self.view.backgroundColor = UIColor.lightGrayColor()
        
        tableView = UITableView(frame: UIScreen.mainScreen().bounds, style: UITableViewStyle.Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = UIColor(red: 237.0/255.0, green: 237.0/255.0, blue: 237.0/255.0, alpha: 1.0)
        self.view.addSubview(tableView)
        //view 320, 504, navview 64
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return SaveData.arrayName.count
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let cell:UITableViewCell=UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        cell.backgroundColor = UIColor.lightGrayColor()
        cell.backgroundColor=UIColor(red: 237.0/255.0, green: 237.0/255.0, blue: 237.0/255.0, alpha: 1.0)
//        let viewg=UIView(frame: CGRectMake(5, 5, 160, 170))
//        viewg.backgroundColor=UIColor.whiteColor()
//        viewg.layer.cornerRadius = 10
        
        let imageofG = UIImageView(frame: CGRectMake(5, 5, 150, 170))
        imageofG.contentMode = .ScaleToFill
        imageofG.clipsToBounds = true
//        let imageName = UIImage(named: "goods")
//        imageofG.image = imageName

        let urlString = SaveData.arrayImageUrl[indexPath.row]
        let url = NSURL(string: urlString)
        imageofG.sd_setImageWithURL(url)
        
        
        let nameofG = UILabel(frame: CGRectMake(190, 5, 400, 30))
        nameofG.text = SaveData.arrayName[indexPath.row]
        
        let priseofG = UILabel(frame: CGRectMake(190, 40, 400, 30))
        priseofG.textColor = UIColor.grayColor()
        priseofG.text = SaveData.arrayPrice[indexPath.row]
        
        buttonofG = UIButton(frame: CGRectMake(150, 140, 200, 25))
        buttonofG.backgroundColor = UIColor.clearColor()
        buttonofG.setTitle("Сделать заказ", forState: .Normal)
        buttonofG.setTitleColor(UIColor.grayColor(), forState: .Normal)
        buttonofG.layer.cornerRadius = 5
        buttonofG.addTarget(self, action: #selector(GoodsforIPViewController.pressed), forControlEvents: .TouchUpInside)
        buttonofG.transform = CGAffineTransformMakeScale(0.6, 0.6)
        
        UIView.animateWithDuration(2.0,
                                   delay: 0,
                                   usingSpringWithDamping: CGFloat(0.20),
                                   initialSpringVelocity: CGFloat(6.0),
                                   options: UIViewAnimationOptions.AllowUserInteraction,
                                   animations: {
                                    self.buttonofG.transform = CGAffineTransformIdentity
            },
                                   completion: { Void in()  }
        )
        
        cell.addSubview(nameofG)
        cell.addSubview(priseofG)
        cell.addSubview(buttonofG)
        cell.addSubview(imageofG)
        return cell;
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        print("press the good")
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return 180
    }
    func pressed(sender: UIButton){
        NSLog("pressed action")
        var phoneNumber = "+77017777777"
        
        let url:NSURL = NSURL(string: "tel://\(phoneNumber)")!
        UIApplication.sharedApplication().openURL(url)
    
        buttonofG.transform = CGAffineTransformMakeScale(0.6, 0.6)
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            self.buttonofG.transform = CGAffineTransformMakeScale(1,1)
            
        })
        
    }
}
