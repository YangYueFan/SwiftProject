//
//  WebCTL.swift
//  Swift_Project2_PlayVideo
//
//  Created by 科技部2 on 2017/9/22.
//  Copyright © 2017年 Ken. All rights reserved.
//

import UIKit

class WebCTL: UIViewController ,UIWebViewDelegate{

    
    public var url = ""
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if url.characters.count > 0 {
            let request = URLRequest(url: URL.init(string: url)!)
            webView.loadRequest(request)
            
        }
    }
    
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        NSLog(error.localizedDescription, 0)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
