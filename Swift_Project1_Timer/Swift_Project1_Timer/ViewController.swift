//
//  ViewController.swift
//  Swift_Project1_Timer
//
//  Created by 科技部2 on 2017/9/18.
//  Copyright © 2017年 Ken. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet weak var resetBtn: UIButton!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var playBtn: UIButton!
    
    var index = 0.0
    
    var timer:Timer! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func resetAction(_ sender: UIButton) {
        index = 0.0
        timeLabel.text = String(format:"%0.1f",index)
    }
    @IBAction func playAction(_ sender: UIButton) {
        
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(addIndex), userInfo: nil, repeats: true)
            timer.fire()
            
            playBtn.setImage(UIImage(named:"play"), for: UIControlState.normal)
        }else{
            timer.fireDate = Date.distantFuture
            playBtn.setImage(UIImage(named:"stop"), for: UIControlState.normal)
            timer.invalidate();
            timer = nil;
        }
        
    }
    
    func addIndex() {
        index += 0.1
        timeLabel.text = String(format:"%0.1f",index)
    }

}

