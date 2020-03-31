//
//  JournalSection.swift
//  Prayer
//
//  Created by Apple on 2018/11/27.
//  Copyright © 2018 CSC 214. All rights reserved.
//

import Foundation

enum JournalSection: Int {
    
    case sorrowful, joyful, luminous, glorious
    
    static let allValues = [sorrowful, joyful, luminous, glorious]
    
    func name() -> String {
        switch self {
        case .sorrowful:                    return NSLocalizedString("str_sorrowful", comment: "")
        case .joyful:                       return NSLocalizedString("str_joyful", comment: "")
        case .luminous:                     return NSLocalizedString("str_luminous", comment: "")
        case .glorious:                     return NSLocalizedString("str_glorious", comment: "")
        }
    }
}
