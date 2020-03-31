//
//  ProphetTile.swift
//  Prayer
//
//  Created by Apple on 2018/12/2.
//  Copyright © 2018 CSC 214. All rights reserved.
//

import UIKit
class ProphetTile: NSObject, NSCoding {
    var index: Int
    var touched: Bool
    var emoji: String
    var name: String
    var image: UIImage
    var changedImage: UIImage
    
    enum CodingKeys: String, CodingKey {
        case index, touched, emoji, name, image, changedImage
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(index, forKey: CodingKeys.index.rawValue)
        aCoder.encode(touched, forKey: CodingKeys.touched.rawValue)
        aCoder.encode(emoji, forKey: CodingKeys.emoji.rawValue)
        aCoder.encode(name, forKey: CodingKeys.name.rawValue)
        aCoder.encode(image, forKey: CodingKeys.image.rawValue)
        aCoder.encode(changedImage, forKey: CodingKeys.changedImage.rawValue)
    }
    
    required init?(coder aDecoder: NSCoder) {
        index = aDecoder.decodeInteger(forKey: CodingKeys.index.rawValue)
        touched = aDecoder.decodeBool(forKey: CodingKeys.touched.rawValue)
        emoji = aDecoder.decodeObject(forKey: CodingKeys.emoji.rawValue) as! String
        name = aDecoder.decodeObject(forKey: CodingKeys.name.rawValue) as! String
        image = aDecoder.decodeObject(forKey: CodingKeys.image.rawValue) as! UIImage
        changedImage = aDecoder.decodeObject(forKey: CodingKeys.changedImage.rawValue) as! UIImage

    }
    init(index: Int, touched: Bool, emoji: String, name: String, image: UIImage, changedImage: UIImage) {
        self.index = index
        self.touched = touched
        self.emoji = emoji
        self.name = name
        self.image = image
        self.changedImage = changedImage
    }
   
}
