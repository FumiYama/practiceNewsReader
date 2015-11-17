//
//  WebViewController.swift
//  practiceNewsReader
//
//  Created by Fumiya Yamanaka on 2015/11/17.
//  Copyright © 2015年 Fumiya Yamanaka. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    
    @IBOutlet var webView: UIWebView! = UIWebView()
    
    var newsUrl: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string: newsUrl)
        
        let urlRequest = NSURLRequest(URL: url!)
        
        webView.loadRequest(urlRequest)

        self.navigationController?.setNavigationBarHidden(false, animated: false) // navigationbar自体を表示

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false) // navigationbar自体を隠す

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
