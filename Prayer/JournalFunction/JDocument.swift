//
//  JDocument.swift
//  Prayer
//
//  Created by Apple on 2018/11/26.
//  Copyright © 2018 CSC 214. All rights reserved.
//

import UIKit

class JDocument: NSObject, NSCoding {
    
    var title: String
    var date: Date
    var sectionType: Int
    var txtF: String
    
    enum CodingKeys: String, CodingKey {
        case title, date, sectionType, txtFTxt
    }
    
    init(title: String, date: Date, sectionType: Int, txtF: String) {
        self.title = title
        self.date = date
        self.sectionType = sectionType
        self.txtF = txtF
    }
    convenience init(title: String) {
        self.init(title: title, date: Date(), sectionType: 0, txtF: "")
    }
    
    required init(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObject(forKey: CodingKeys.title.rawValue) as! String
        date = aDecoder.decodeObject(forKey: CodingKeys.date.rawValue) as! Date
        if let st = aDecoder.decodeObject(forKey: CodingKeys.sectionType.rawValue) as? Int{
            self.sectionType = st
        }else {
            self.sectionType = 0
        }
        txtF = aDecoder.decodeObject(forKey: CodingKeys.txtFTxt.rawValue) as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: CodingKeys.title.rawValue)
        aCoder.encode(date, forKey: CodingKeys.date.rawValue)
        aCoder.encode(sectionType, forKey: CodingKeys.sectionType.rawValue)
        aCoder.encode(txtF, forKey: CodingKeys.txtFTxt.rawValue)
    }
    
}


















