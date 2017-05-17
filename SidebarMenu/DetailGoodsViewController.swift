//
//  DetailGoodsViewController.swift
//  TaxUnion
//
//  Created by Bakbergen on 8/6/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class DetailGoodsViewController: UIViewController {
    
    var DetailGoodsImage: UIImageView = UIImageView()
    var DetailGoodsTextView: UITextView = UITextView()
    var DetailPriceLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DetailGoodsImage = UIImageView(frame: CGRectMake(5, 5, UIScreen.mainScreen().bounds.width-10, UIScreen.mainScreen().bounds.height-10))
        let imageName = UIImage(named: "")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
