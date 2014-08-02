//
//  Note.swift
//  MyNotesSwift
//
//  Created by Wiley Wimberly on 8/2/14.
//  Copyright (c) 2014 Warm Fuzzy Apps, LLC. All rights reserved.
//

import UIKit

let noteContentKey = "noteContentKey"
let noteModificationDateKey = "noteModificationDateKey"

class Note: NSObject, NSCoding {
    
    var content: String {
    didSet {
        if content != oldValue {
            modificationDate = NSDate()
        }
    }
    }
    
    var modificationDate: NSDate
    
    var title: String {
    var title = content
        let start = title.startIndex
        let end = find(title, "\n")
        if end {
            title = title[start..<end!]
        }
        return title
    }
    
    // MARK: - Initialization
    
    init() {
        content = ""
        modificationDate = NSDate()
    }
    
    // MARK: - NSCoding
    
    func encodeWithCoder(aCoder: NSCoder!) {
        aCoder.encodeObject(content, forKey:noteContentKey)
        aCoder.encodeObject(modificationDate, forKey:noteModificationDateKey)
    }
    
    init(coder aDecoder: NSCoder!) {
        content = aDecoder.decodeObjectForKey(noteContentKey) as String
        modificationDate = aDecoder.decodeObjectForKey(noteModificationDateKey) as NSDate
        super.init()
    }
}
