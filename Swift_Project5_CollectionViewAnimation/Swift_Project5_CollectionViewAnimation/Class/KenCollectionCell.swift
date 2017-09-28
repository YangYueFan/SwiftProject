//
//  KenCollectionCell.swift
//  Swift_Project5_CollectionViewAnimation
//
//  Created by 科技部2 on 2017/9/27.
//  Copyright © 2017年 Ken. All rights reserved.
//

import UIKit

class KenCollectionCell: UICollectionViewCell {
    
    
    public var rect = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    public var isBig = false
    
    
    @IBOutlet weak var imgVIew: UIImageView!
    
    
    @IBOutlet weak var backBtn: UIButton!
    
    var backButtonTapped: (() -> Void)?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layer.cornerRadius = 8;
        self.layer.masksToBounds = true
        
        self.backBtn.layer.cornerRadius = 20;
        self.backBtn.layer.masksToBounds = true;
        
        self.backBtn.isHidden = true;
        
        self.imgVIew.layer.masksToBounds = true
    }

    @IBAction func backAction(_ sender: UIButton) {
        
        backButtonTapped?()
        
    }

}
