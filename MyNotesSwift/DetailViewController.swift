//
//  DetailViewController.swift
//  MyNotesSwift
//
//  Created by Wiley Wimberly on 8/2/14.
//  Copyright (c) 2014 Warm Fuzzy Apps, LLC. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var note: Note?
    var completion:(() -> ())?
    var newNote = false;
    
    // MARK: - Outlets
    
    @IBOutlet weak var modificationDateLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if newNote == false {
            navigationItem.rightBarButtonItem = nil
            navigationItem.leftBarButtonItem = nil
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let note = self.note? {
            var formatter = NSDateFormatter()
            formatter.timeStyle = .ShortStyle
            formatter.dateStyle = .LongStyle
            
            modificationDateLabel.text = formatter.stringFromDate(note.modificationDate)
            contentTextView.text = note.content
        }
        
        if newNote == true {
            contentTextView.becomeFirstResponder()
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        if newNote == false {
            if let note = self.note {
                if note.content != contentTextView.text {
                    note.content = contentTextView.text
                }
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction func doneTapped(sender: UIBarButtonItem) {
        if let note = self.note? {
            note.content = contentTextView.text
        }
        
        if let completion = self.completion? {
            completion()
        }
        presentingViewController.dismissViewControllerAnimated(true, completion: nil);
    }
    
    @IBAction func cancelTapped(sender: UIBarButtonItem) {
        presentingViewController.dismissViewControllerAnimated(true, completion: nil);
    }
}

