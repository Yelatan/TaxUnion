//
//  RegisterViewController.swift
//  TaxUnion
//
//  Created by Bakbergen on 8/3/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var repeatpasswordTextField: UITextField!
    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var nalogRezhimTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func HaveAccountButton(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion:nil)
    }
    
    @IBAction func RegisterButtonTapped(sender: AnyObject) {
        let userEmail = emailTextField.text
        let userPassword = passwordTextField.text
        let userRepeatPassword = repeatpasswordTextField.text
        let userPhone = phoneTextField.text
        let userNalogRezhim = nalogRezhimTextField.text
    //checking for empty fiels:
        if (userEmail!.isEmpty || userPassword!.isEmpty || userRepeatPassword!.isEmpty){
            
            //Display alert message
            displayAlertMessage("All fields are required")
            return
        }
        
        //checking for matching
        if(userPassword != userRepeatPassword){
            displayAlertMessage("Password do not match")
            return
        }
        
        let headers = [
            "cache-control": "no-cache",
            "postman-token": "3205502f-bf7e-ec97-4e49-c558c4bbb3ff"
        ]
        
        var request = NSMutableURLRequest(URL: NSURL(string: "http://cabinet.taxunion.kz/register.php?iin="+userEmail!+"&password="+userPassword!+"&phone="+userPhone!+"&nalog="+userNalogRezhim!)!,
                                          cachePolicy: .UseProtocolCachePolicy,
                                          timeoutInterval: 10.0)
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
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
                var isUserRegistered:Bool = false
                
                if let parseJSONstatus = json["status"] as? String {
                    print("result: \(parseJSONstatus)")
                    if(parseJSONstatus == "OK") {
                        isUserRegistered = true
                    }
                }
                var messageToDisplay : String = (json["message"] as? String)!
                
                if(!isUserRegistered){
                    messageToDisplay = (json["message"] as? String)!
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    //display alert message
                    var myAlert = UIAlertController(title: "Alert", message: messageToDisplay, preferredStyle: UIAlertControllerStyle.Alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default){ action in
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }
                    
                    myAlert.addAction(okAction)
                    self.presentViewController(myAlert, animated: true, completion: nil)
                })
            } catch {
                print("error serializing JSON: \(error)")
            }
        })
        dataTask.resume()
        
    }
    
    func displayAlertMessage(userMessage: String){
        var alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        var okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        
        alert.addAction(okAction)
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    

 
}
