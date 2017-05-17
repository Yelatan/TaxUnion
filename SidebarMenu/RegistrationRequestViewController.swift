//
//  RegistrationRequestViewController.swift
//  TaxUnion
//
//  Created by Bakbergen on 8/2/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import Foundation

class RegistrationRequestViewController: UIViewController {
    
    override func viewDidLoad(){
        let url = NSURL(string: "http://cabinet.taxunion.kz/register.php")
        let request = NSMutableURLRequest(URL:url!)
        request.HTTPMethod = "GET"
        
        let string = "?iin=12345623"
       
        
        request.HTTPBody = string.dataUsingEncoding(NSUTF8StringEncoding)
        
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            print("******  response = \(response)")
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("****** response data = \(responseString)")
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSDictionary
                
                if let parseJSON = json["message"] as? [[String: AnyObject]] {
//                    var message = parseJSON["status"] as? String
                    print("status:=\(parseJSON)")
                }
                
                
            } catch {
                print("error serializing JSON: \(error)")
            }
        }
        
        task.resume()
        
    }
    
}