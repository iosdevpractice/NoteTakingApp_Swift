//
//  MasterViewController.swift
//  MyNotesSwift
//
//  Created by Wiley Wimberly on 8/2/14.
//  Copyright (c) 2014 Warm Fuzzy Apps, LLC. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    
    var noteStore = NoteStore()
    
    var notes: [Note] {
    get {
        return noteStore.notes
    }
    set {
        noteStore.notes = newValue
    }
    }
    
    lazy var dateFormatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.timeStyle = .ShortStyle
        formatter.timeStyle = .ShortStyle
        return formatter
        }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            
            let indexPath = self.tableView.indexPathForSelectedRow()
            let note = notes[indexPath.row]
            (segue.destinationViewController as DetailViewController).note = note
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "Notes", style: .Plain, target: nil, action: nil)
            
        } else if segue.identifier == "addNote" {
            
            var note = Note()
            let nc = segue.destinationViewController as UINavigationController
            let dvc = nc.topViewController as DetailViewController
            dvc.note = note
            dvc.newNote = true
            dvc.completion = {
                self.notes.insert(note, atIndex: 0)
                let first = NSIndexPath(forItem: 0, inSection: 0)
                self.tableView.insertRowsAtIndexPaths([first], withRowAnimation: .Automatic)
            }
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->
        UITableViewCell {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
            
            let note = notes[indexPath.row]
            
            cell.textLabel.text = note.title
            cell.detailTextLabel.text = dateFormatter.stringFromDate(note.modificationDate)
            return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            notes.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let tmpNote = notes[sourceIndexPath.row]
        notes.removeAtIndex(sourceIndexPath.row)
        notes.insert(tmpNote, atIndex: destinationIndexPath.row)
    }
}

