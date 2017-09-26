//
//  ViewController.swift
//  Swift_Project3_LoginGIF
//
//  Created by 科技部2 on 2017/9/25.
//  Copyright © 2017年 Ken. All rights reserved.
//

import UIKit
import ImageIO

class ViewController: UIViewController {

    
    @IBOutlet weak var accountTF: UITextField!
    
    @IBOutlet weak var passworkTF: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    
    
    @IBOutlet weak var bgImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadImageGIF()
        
        accountTF.setValue(UIColor.gray, forKeyPath: "_placeholderLabel.textColor")
        accountTF.layer.borderColor = UIColor.gray.cgColor
        accountTF.layer.borderWidth = 1
        accountTF.layer.cornerRadius = 5;
        accountTF.layer.masksToBounds = true
        
        passworkTF.setValue(UIColor.gray, forKeyPath: "_placeholderLabel.textColor")
        passworkTF.layer.borderWidth = 1
        passworkTF.layer.borderColor = UIColor.gray.cgColor
        passworkTF.layer.cornerRadius = 5;
        passworkTF.layer.masksToBounds = true
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.05, animations: {
            self.frameSetting(contentView: self.accountTF)
            self.frameSetting(contentView: self.passworkTF)
            self.frameSetting(contentView: self.loginBtn)
        })

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.25, execute: {
            self.animate(contentView: self.accountTF)
        })

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.50, execute: {
             self.animate(contentView: self.passworkTF)
        })
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.75, execute: {
            self.animate(contentView: self.loginBtn)
        })   
    }
    
    func loadImageGIF()  {
        let path = Bundle.main.path(forResource: "00", ofType: "gif")
        
        let data = NSData(contentsOfFile:path!)
        
        
        let imageSoure = CGImageSourceCreateWithData(data!, nil)
        
        var images = [UIImage]()
        
        let time :TimeInterval = 2
        
        for i in 0..<CGImageSourceGetCount(imageSoure!) {
            let cgImage = CGImageSourceCreateImageAtIndex(imageSoure!, i, nil)
            let image = UIImage(cgImage: cgImage!)
            images.append(image)
        }
        bgImageView.animationImages = images
        bgImageView.animationDuration = time
        bgImageView.animationRepeatCount = 0
        bgImageView.startAnimating()
    }
    
    
    func animate(contentView:UIView) {
        
        var frame1 = contentView.frame
        NSLog(NSStringFromCGRect(frame1), 1)
        UIView.animate(withDuration: 0.5, animations: { 
            frame1.origin.x += UIScreen.main.bounds.size.width
            contentView.frame = frame1
            NSLog(NSStringFromCGRect(frame1) + "animate", 1)
        })
 
    }
    
    
    func frameSetting(contentView:UIView) {
        var frame1 = contentView.frame
        frame1.origin.x -= UIScreen.main.bounds.size.width
        contentView.frame = frame1;
         NSLog(NSStringFromCGRect(contentView.frame) + "frameSetting", 1)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

