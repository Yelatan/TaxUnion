//
//  LoginViewController.swift
//  TaxUnion
//
//  Created by Bakbergen on 8/3/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit



class LoginViewController: UIViewController {
    
    @IBOutlet var EmailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    var arrayName = [String]()
    var arrayPrice = [String]()
    var arrayImageUrl = [String]()
    var arrayDescription = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData(){
        
        var userEmail = EmailTextField.text
        var userPassword = passwordTextField.text
        
        
        if(userEmail!.isEmpty || userPassword!.isEmpty) {return}
        
        let headers = [
            "cache-control": "no-cache",
            "postman-token": "aa634619-6f1a-93e8-f713-8e3c60b821b2"
        ]
        
        var request = NSMutableURLRequest(URL: NSURL(string: "http://cabinet.taxunion.kz/login.php?iin="+userEmail!+"&password="+userPassword!)!,
                                          cachePolicy: .UseProtocolCachePolicy,
                                          timeoutInterval: 10000.0)
        request.HTTPMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? NSHTTPURLResponse
                print(httpResponse)
            }
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSDictionary
                var isUserRegistered:Bool = false
                
                
                if let parseJSONstatus = json["status"] as? String {
                    print("result: \(parseJSONstatus)")
                    if(parseJSONstatus == "OK") {
                        //                        user is successful
                        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "Logenter")
                        NSUserDefaults.standardUserDefaults().synchronize()
                        self.dismissViewControllerAnimated(true, completion: nil)
                        
                        if let goodsData = json["tovari"] as? [[String: AnyObject]]{
                            for goods in goodsData{
                                let name: String? = goods["name"] as? String
                                self.arrayName.append(name!)
                                self.arrayPrice.append((goods["price"] as? String)!)
                                self.arrayImageUrl.append((goods["image"] as? String)!)
                                self.arrayDescription.append((goods["description"] as? String)!)
                                var SaveData =  SaveDataViewController.sharedInstance
                                SaveData.arrayName = self.arrayName
                                SaveData.arrayPrice = self.arrayPrice
                                SaveData.arrayImageUrl = self.arrayImageUrl
                                SaveData.arrayDescription = self.arrayDescription
                            }
                            NSUserDefaults.standardUserDefaults().setObject(goodsData,forKey:"tovari")
                            
                        }
                        print(self.arrayName)
                        
                    }
                    else if(parseJSONstatus == "ERROR"){
                        var messageToDisplay : String = (json["message"] as? String)!
                        dispatch_async(dispatch_get_main_queue(), {
                            //display alert message
                            var myAlert = UIAlertController(title: "Alert", message: messageToDisplay, preferredStyle: UIAlertControllerStyle.Alert)
                            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default){ action in
                            }
                            
                            myAlert.addAction(okAction)
                            self.presentViewController(myAlert, animated: true, completion: nil)
                        })
                    }
                }
                
            } catch {
                print("error serializing JSON: \(error)")
            }
        })
        dataTask.resume()
    }
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
      self.loadData()
    }
}

