//
//  TableViewCell.swift
//  Swift_Project2_PlayVideo
//
//  Created by 科技部2 on 2017/9/18.
//  Copyright © 2017年 Ken. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    

    @IBOutlet weak public var imgView: UIImageView!
    
    @IBOutlet weak public var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
