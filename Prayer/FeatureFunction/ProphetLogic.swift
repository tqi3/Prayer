//
//  ProphetLogic.swift
//  Prayer
//
//  Created by Apple on 2018/11/28.
//  Copyright © 2018 CSC 214. All rights reserved.
//

import UIKit

class ProphetLogic: NSObject, NSCoding {
    
    enum CodingKeys: String, CodingKey {
        case tArry
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(tilesArray, forKey: CodingKeys.tArry.rawValue)
    }
    
    required init?(coder aDecoder: NSCoder) {
        tilesArray = aDecoder.decodeObject(forKey: CodingKeys.tArry.rawValue) as! Array
    }
    
    let emojis = ["❤️", "🧡", "💛", "💚", "💙", "💜", "🖤", "💝"]
    let names = [NSLocalizedString("str_amos", comment: ""), NSLocalizedString("str_daniel", comment: ""), NSLocalizedString("str_samuel", comment: ""), NSLocalizedString("str_ezekiel", comment: ""), NSLocalizedString("str_matthew", comment: ""), NSLocalizedString("str_john", comment: ""), NSLocalizedString("str_mark", comment: ""), NSLocalizedString("str_luke", comment: "")]
    let images = [#imageLiteral(resourceName: "Amos"), #imageLiteral(resourceName: "Daniel"), #imageLiteral(resourceName: "Samuel"), #imageLiteral(resourceName: "Ezekiel"), #imageLiteral(resourceName: "Matthew"), #imageLiteral(resourceName: "John"), #imageLiteral(resourceName: "Mark"), #imageLiteral(resourceName: "Luke")]
    
    let changedImages = [#imageLiteral(resourceName: "Amos").tint(with: .red, alpha: 0.5, blendmode: .normal), #imageLiteral(resourceName: "Daniel").tint(with: .orange, alpha: 0.5, blendmode: .normal), #imageLiteral(resourceName: "Samuel").tint(with: .yellow, alpha: 0.5, blendmode: .normal),#imageLiteral(resourceName: "Ezekiel").tint(with: .green, alpha: 0.5, blendmode: .normal), #imageLiteral(resourceName: "Matthew").tint(with: .blue, alpha: 0.5, blendmode: .normal),#imageLiteral(resourceName: "John").tint(with: .purple, alpha: 0.5, blendmode: .normal),#imageLiteral(resourceName: "Mark").tint(with: .black, alpha: 0.5, blendmode: .normal),#imageLiteral(resourceName: "Luke").tint(with: .gray, alpha: 0.5, blendmode: .normal)]
    
    var tilesArray: [ProphetTile]!
    
    override init() {
        super.init()
    }
    
    
    func initGame() {
        for i in 0..<8 {
            let tile = ProphetTile(index: i, touched: false, emoji: emojis[i], name: names[i], image: images[i], changedImage: changedImages[i])
            tilesArray.append(tile)
        }
    }
    
    func isTouched(_ index: Int) -> Bool {
        return tilesArray[index].touched
    }
    
    func allTouched() -> Bool {
        for oneTile in tilesArray {
            if(!oneTile.touched) {
                return false
            }
        }
        return true
    }
    
    func touchedTiles() -> [ProphetTile] {
        return tilesArray.filter { $0.touched == true }
    }
    
    
    func labelName(for index: Int) -> String? {
        guard index < tilesArray.count else { return nil }
        let tile = tilesArray[index]
        return tile.touched ? tile.emoji : tile.name
    }
    
    func imageLike(for index: Int) -> UIImage? {
        guard index < tilesArray.count else { return nil }
        let tile = tilesArray[index]
        return tile.touched ? tile.changedImage : tile.image
    }
    
    
    func allTilesResetBack() {
        for i in 0..<tilesArray.count {
            tilesArray[i].touched = false
        }
    }
}
