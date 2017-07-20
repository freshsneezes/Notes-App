//
//  ListNotesTableViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit

class ListNotesTableViewController: UITableViewController {
    
    //Saving notes
    var notes = [Note]() {
        //didSet is a property observer, here it's telling the table view to refresh whenever notes changes
        didSet {
            tableView.reloadData()
        }
    }
    
    //Load view
    override func viewDidLoad() {
        super.viewDidLoad()
        //Bc. want to update notes everytime the list is displayed
        notes = CoreDataHelper.retrieveNote()
    }
    
    
    
    //1 - tells table view how many cells to display
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    
    
    //2 - tells table view which cell goes where
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //3 - tells table view what type of cell to use
        let cell = tableView.dequeueReusableCell(withIdentifier: "listNotesTableViewCell", for: indexPath) as! ListNotesTableViewCell
        //4 - table view says what row it wants a cell for
        let row  = indexPath.row
        
        //5 - gets appropriate note using the notes array
        let note = notes[row]
        //6 - pulls title that was saved, sets the label to whatever the title was
        cell.noteTitleLabel.text = note.title
        //7 - calls the date and sets date label
        cell.noteModificationTimeLabel.text = note.modificationTime?.convertToString()
        
        //8 - display cell
        return cell
    }
    
    
    
    //Go to editor
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //1 - stores identifier of segue that was triggered in variable identifier
        if let identifier = segue.identifier {
            //2 - checks which segue was triggered
            if identifier == "DisplayNote" {
                //3 - message to console
                print ("Table view cell tapped")
                
                //4 - finding selected cell's index path from the notes array, OK to use force unwrapping because accessing optional from its storage spot
                let indexPath = tableView.indexPathForSelectedRow!
                //5 - finding selected cell's row
                let note = notes[indexPath.row]
                //6 - determining destination for note
                let displayNoteViewController = segue.destination as! DisplayNoteViewController
                //7 - accessing note from destination
                displayNoteViewController.note = note
                
            } else if identifier == "AddNote" {
                print ("+ button tapped")
            }
        }
    }
    
    //1 - allows table to use other editing modes, user can delete if they swipe right
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //2 - checks if editing style selected is delete
        if editingStyle == .delete {
            //3 - actually deleting note
            CoreDataHelper.deleteNote(note: notes[indexPath.row])
            //4 - updating notes list
            notes = CoreDataHelper.retrieveNote()
        }
    }
    
    //Go back to notes list
    @IBAction func unwindToListNotesViewController(_ segue: UIStoryboardSegue) {
        //Bc want to update list of notes everytime screen goes back to it
        self.notes = CoreDataHelper.retrieveNote()
    }
    
}
