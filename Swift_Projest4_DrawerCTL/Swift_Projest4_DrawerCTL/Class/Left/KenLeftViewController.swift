//
//  KenLeftViewController.swift
//  Swift_Projest4_DrawerCTL
//
//  Created by 科技部2 on 2017/9/26.
//  Copyright © 2017年 Ken. All rights reserved.
//

import UIKit

class KenLeftViewController: UIViewController  ,UITableViewDelegate,UITableViewDataSource{

    
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Left"
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(arc4random()%3)+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil{
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        }
        
        cell?.textLabel?.text = "第"+"\(indexPath.row)"+"行"
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: true)
        
        appDelegate.drawerCTL?.toggle(.left, animated: true, completion: { (finished) in
            
            
            NSLog("第"+"\(indexPath.row)"+"行", 1)
            
            
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
