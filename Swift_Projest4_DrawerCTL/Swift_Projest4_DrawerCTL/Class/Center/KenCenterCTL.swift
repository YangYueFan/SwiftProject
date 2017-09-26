//
//  KenCenterCTL.swift
//  Swift_Projest4_DrawerCTL
//
//  Created by 科技部2 on 2017/9/26.
//  Copyright © 2017年 Ken. All rights reserved.
//

import UIKit

class KenCenterCTL: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    //创建一个空字典
//    var dicData = [String : Bool]()
    
    // MARK: - 懒加载
    lazy var dicData : Dictionary = {
        
        () -> Dictionary<String, Bool> in
        
            let dicData = ["None":true,
                           "Slide":false,
                           "Slide and Scale":false,
                           "Swinging Door":false,
                           "Parallax":false]
        return dicData
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Center"
        
        let leftBtnItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action:  #selector(leftItemAction))
        self.navigationItem.leftBarButtonItem = leftBtnItem
        
        //执行动画
        launchAnimation()
  
    }
    
    // MARK: - 播放启动画面动画
    func launchAnimation()  {
        
        //获取启动视图
        let launch = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateViewController(withIdentifier:"launch")
        let launchView = launch.view
        
        
        appDelegate.window?.addSubview(launchView!)
        
        UIView.animate(withDuration: 1, delay: 0, options: .beginFromCurrentState, animations: { 
            
            launchView?.alpha = 0.0;
            let transform = CATransform3DScale(CATransform3DIdentity, 1.5, 1.5, 1)
            launchView?.layer.transform = transform
            
        }) { (bool) in
            
            launchView?.removeFromSuperview()
        }
    }
    
    
    // MARK: - Button Handlers
    func leftItemAction() {
        appDelegate.drawerCTL?.toggle(.left, animated: true, completion: nil)
        
    }
    

    
    // MARK: - UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dicData.keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil{
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        }
        let arr = [String](dicData.keys)
        cell?.textLabel?.text = arr[indexPath.row]
        if dicData[arr[indexPath.row]] == false{
            cell?.accessoryType = .none
        }else{
            cell?.accessoryType = .checkmark
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let arr = [String](dicData.keys)
        let keyStr = arr[indexPath.row]
        
        for key in arr {
            
            if key == keyStr {
                dicData[key] = true
            }else{
                dicData[key] = false
            }
            
        }
        
        tableView.reloadData()
        
        
        switch keyStr {
        case "None":
            MMExampleDrawerVisualStateManager.shared().leftDrawerAnimationType = MMDrawerAnimationType.none
            break
        case "Slide":
            MMExampleDrawerVisualStateManager.shared().leftDrawerAnimationType = MMDrawerAnimationType.slide
            break
        case "Slide and Scale":
            MMExampleDrawerVisualStateManager.shared().leftDrawerAnimationType = MMDrawerAnimationType.slideAndScale
            break
        case "Swinging Door":
            MMExampleDrawerVisualStateManager.shared().leftDrawerAnimationType = MMDrawerAnimationType.swingingDoor
        case "Parallax":
            MMExampleDrawerVisualStateManager.shared().leftDrawerAnimationType = MMDrawerAnimationType.parallax
            break

        default: break
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Left Drawer Animation"
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
