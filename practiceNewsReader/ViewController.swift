//
//  ViewController.swift
//  practiceNewsReader
//
//  Created by Fumiya Yamanaka on 2015/11/17.
//  Copyright © 2015年 Fumiya Yamanaka. All rights reserved.
//

import UIKit
// Alamofireライブラリのインポート
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var newsDataArray = NSArray()
    var newsUrl:String = ""
    @IBOutlet var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        table.dataSource = self
        table.delegate = self
        let url = "https://ajax.googleapis.com/ajax/services/search/news?v=1.0&topic=p&hl=ja&rsz=8"
        
        Alamofire.request(.GET, url).responseJSON {
            response in
            if response.result.isSuccess {
                // JSONデータをDirectory型に
                let jsonDic = response.result.value as! NSDictionary
                // 辞書化したjsonDicからキー値”responseData”を所得
                let responseData = jsonDic["responseData"] as! NSDictionary
                // responseDataからキー値"results"を取得
                self.newsDataArray = responseData["results"] as! NSArray
                self.table.reloadData()
                
                print("\(self.newsDataArray)")
            }
        }
        
        self.navigationController?.setNavigationBarHidden(true, animated: false) // navigationbar自体を隠す

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // セルの数
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        let newsDic = newsDataArray[indexPath.row] as! NSDictionary
        cell.textLabel?.text = newsDic["title"] as? String
        cell.textLabel?.numberOfLines = 3
        cell.detailTextLabel?.text = newsDic["publishedData"] as? String
        
        return cell
    }
    
    // tableViewがタップされた時のメソッド
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        NSLog("タップされたインデックス：\(indexPath.row)")
        
        let newsDic = newsDataArray[indexPath.row] as! NSDictionary //ニュース記事データ取得
        newsUrl = newsDic["unescapedUrl"] as! String // url取得
//        let url = NSURL(string: newsUrl) // stringをnsurl型に変換
//        let app = UIApplication.sharedApplication() // UIApplicaitonインスタンス作成
//        app.openURL(url!) // openURLメソッドでurlを引数にwebブラウザsafariを起動
        
        performSegueWithIdentifier("toWebView", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let wvc = segue.destinationViewController as! WebViewController
        wvc.newsUrl = self.newsUrl
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // セクションの数
        return newsDataArray.count
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

