//
//  JLibrary.swift
//  Prayer
//
//  Created by Apple on 2018/11/27.
//  Copyright © 2018 CSC 214. All rights reserved.
//

import UIKit

class JLibrary: NSObject, NSCoding {
    
    var sectionJournalsCollection: [[JDocument]]
    var sectionDatesCollection: [Int]
    
    enum CodingKeys: String, CodingKey {
        case sectionJournalsCollection, sectionDatesCollection
    }
    
    override init() {
        sectionJournalsCollection = [[], [], [], []]
        sectionDatesCollection = [0, 0, 0, 0]
    }
    
    
    func addJournalBySection(_ journal: JDocument, _ sectionType: JournalSection) {
        sectionDatesCollection[sectionType.rawValue] =  sectionDatesCollection[sectionType.rawValue] + 1
        let day = NSLocalizedString("str_day", comment: "")
        journal.title = day + String(sectionDatesCollection[sectionType.rawValue])
        journal.sectionType = sectionType.rawValue
        sectionJournalsCollection[sectionType.rawValue].append(journal)
    }
    
    func removeJournalBySection(at index: Int, _ sectionType: JournalSection) ->Bool {
        if(sectionJournalsCollection[sectionType.rawValue].count == 0) {
            return true
        } else {
            sectionJournalsCollection[sectionType.rawValue].remove(at: index)
            return false
        }
    }
    
    func moveJournalBySection(fromIndex: Int, toIndex: Int, _ sectionType: JournalSection) {
        if fromIndex != toIndex {
            let journal = sectionJournalsCollection[sectionType.rawValue][fromIndex]
            sectionJournalsCollection[sectionType.rawValue].remove(at: fromIndex)
            sectionJournalsCollection[sectionType.rawValue].insert(journal, at: toIndex)
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        sectionJournalsCollection = aDecoder.decodeObject(forKey: CodingKeys.sectionJournalsCollection.rawValue) as! Array
        sectionDatesCollection = aDecoder.decodeObject(forKey: CodingKeys.sectionDatesCollection.rawValue) as! Array
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(sectionJournalsCollection, forKey: CodingKeys.sectionJournalsCollection.rawValue)
        aCoder.encode(sectionDatesCollection, forKey: CodingKeys.sectionDatesCollection.rawValue)
    }
    
}
