//
//  ViewController.swift
//  Swift_Project2_PlayVideo
//
//  Created by 科技部2 on 2017/9/18.
//  Copyright © 2017年 Ken. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    
    @IBOutlet weak var myTableView: UITableView!
    var dataSoure = Array<Any>();
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        myTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        self.automaticallyAdjustsScrollViewInsets = false
        self.loadData()
    }
    
    
    
    func loadData() {
        
        let tmpCode = String(format:"%ld",Date.timeIntervalBetween1970AndReferenceDate)
        let token = "35c76136a50647c14f8d7650b2573425" + tmpCode
        AFNTool.shareInstance.reqest(methodType: RequestType.GET, urlString: "http://api.sgcarlife.com", parameters: ["tmpcode":tmpCode ,"token":token,"from":"ios","method":"Init_getSubjectTwoData"]) { (result : AnyObject?, error : Error?) in
            
            
            if error != nil{
            
                print(error!)
            }else{
               
                self.dataSoure = result!["data"] as! Array<[String : String]>
                self.myTableView.reloadData()
            }
            
        }
    }
    


    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSoure.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TableViewCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        let dic = dataSoure[indexPath.row]
        cell.titleLabel.text = (dic as? [String : String])?["title"]
       
        cell.imgView.sd_setImage(with: NSURL(string:String(format:"http://www.sgcarlife.com/%@",((dic as? [String : String])?["thumb"])!))! as URL, completed: nil)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return (UIScreen.main.bounds.size.width * 150.0) / 320.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let webCtl = WebCTL()
        let dic = dataSoure[indexPath.row]
        webCtl.url = ((dic as? [String : String])?["link"])!
        self.navigationController?.pushViewController(webCtl, animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

