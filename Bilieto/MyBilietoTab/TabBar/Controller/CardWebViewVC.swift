//
//  CardWebViewVC.swift
//  Bilieto
//
//  Created by PC on 26/09/18.
//  Copyright © 2018 Amisha. All rights reserved.
//

import UIKit

class CardWebViewVC: UIViewController {

    @IBOutlet var webView: UIWebView!
    
    var cardUserId : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let str = "http://beta.bilieto.com/bilieto/bilietomobile/" + "\(cardUserId)"
        let url = URL(string: str)
        webView.loadRequest(URLRequest(url: url!))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
