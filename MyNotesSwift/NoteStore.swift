//
//  NoteStore.swift
//  MyNotesSwift
//
//  Created by Wiley Wimberly on 8/2/14.
//  Copyright (c) 2014 Warm Fuzzy Apps, LLC. All rights reserved.
//

import UIKit

let noteStoreSaveFile = "notes.data"

class NoteStore: NSObject {
    
    var notes = [Note]()
    
    // MARK: - Initialization
    
    override init() {
        super.init()
        
        let notesData = NSData(contentsOfURL:savePath())
        if (notesData != nil) {
            notes = NSKeyedUnarchiver.unarchiveObjectWithData(notesData) as [Note]
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("save"), name: UIApplicationWillResignActiveNotification, object: nil)
        
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK: -
    
    func savePath() -> NSURL {
        let fileManager = NSFileManager.defaultManager()
        let documentsDirectory = fileManager.URLForDirectory(.DocumentDirectory, inDomain:.UserDomainMask, appropriateForURL: nil, create: false, error: nil)
        let path = documentsDirectory.URLByAppendingPathComponent(noteStoreSaveFile)
        return path
    }
    
    func save() {
        let data = NSKeyedArchiver.archivedDataWithRootObject(notes)
        data.writeToURL(savePath(), atomically: true)
    }
}
