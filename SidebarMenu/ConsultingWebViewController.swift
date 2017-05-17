//
//  ConsultingWebViewController.swift
//  SidebarMenu
//
//  Created by Bakbergen on 7/10/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import Foundation

class ConsultingWebViewController: UIViewController{
    
    var textView: UITextView = UITextView()
    var priceText = "price"
    var descriptionText = "descr"
    var priceLabel : UILabel = UILabel()
    
   
    
    
    override func viewDidLoad() {
        
//        let navController = UINavigationController()
//        let WebView = UIWebView(frame: CGRectMake(0,0,400,100))
//        webView.loadRequest(NSURLRequest(URL: NSURL(string: "https://www.google.pl/#q=taxunion.kz")!))
//        self.view.addSubview(WebView)
        
        
        textView = UITextView(frame: CGRectMake(10, 100, 200, 100))
        textView.text = descriptionText
        textView.scrollEnabled = true
        textView.backgroundColor = UIColor.brownColor()
        textView.textColor = UIColor.cyanColor()
        textView.textAlignment = NSTextAlignment.Center
        self.view.addSubview(textView)
        
        priceLabel = UILabel(frame: CGRectMake(10, 400,200,30))
        print(priceText)
        priceLabel.text = priceText
        priceLabel.backgroundColor = UIColor.brownColor()
        priceLabel.textColor = UIColor.cyanColor()
        priceLabel.textAlignment = NSTextAlignment.Center
        view.addSubview(priceLabel)
        
    }
    
    
    
    
}