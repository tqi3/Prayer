//
//  PLibrary.swift
//  Prayer
//
//  Created by Apple on 2018/12/3.
//  Copyright © 2018 CSC 214. All rights reserved.
//

import UIKit
class PLibrary: NSObject, NSCoding {
    
    var photosCollection: [UIImage]
    
    enum CodingKeys: String, CodingKey {
        case photosCollection
    }
    
    override init() {
        photosCollection = []
    }
    
    
    func addPhoto(_ p: UIImage) {
        photosCollection.append(p)
    }
    
    func removePhoto(at index: Int) {
        photosCollection.remove(at: index)
    }
    
    required init(coder aDecoder: NSCoder) {
        photosCollection = aDecoder.decodeObject(forKey: CodingKeys.photosCollection.rawValue) as! Array
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(photosCollection, forKey: CodingKeys.photosCollection.rawValue)
    }
    
}
