//
//  ResultCell.swift
//  Prayer
//
//  Created by Apple on 2018/11/30.
//  Copyright © 2018 CSC 214. All rights reserved.
//

import UIKit

class ResultCell: UITableViewCell {
    
    @IBOutlet weak var VerseText: UILabel!
    @IBOutlet weak var VerseNum: UILabel!
    @IBOutlet weak var Chapter: UILabel!
    @IBOutlet weak var Book: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
