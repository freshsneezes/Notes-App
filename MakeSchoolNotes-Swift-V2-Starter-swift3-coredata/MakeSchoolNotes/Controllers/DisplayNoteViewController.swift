//
//  DisplayNoteViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit

class DisplayNoteViewController: UIViewController {
    
    var note: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let listNotesTableViewController = segue.destination as! ListNotesTableViewController
        //If note exists, update title & content
        if segue.identifier == "Save" {
            let note = self.note ?? CoreDataHelper.newNote()
            // Saving note's title & content from what's in the text view
            note.title = noteTitleTextField.text ?? ""
            note.content = noteContentTextView.text ?? ""
            note.modificationTime = Date() as NSDate
            // Actually saving the note
            CoreDataHelper.saveNote()
        }
    }
    
    @IBOutlet weak var noteTitleTextField: UITextField!

    @IBOutlet weak var noteContentTextView: UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //1 - check whether note == nil or not, if it isn't then it loads its contents, else it starts off with blanks
        if let note = note {
            //2 - Loading contents
            noteTitleTextField.text = note.title
            noteContentTextView.text = note.content
        } else {
            //3 - Loading blanks
            noteTitleTextField.text = ""
            noteContentTextView.text = ""
        }
        
        /* Simplified version of if let statement:
            noteTitleTextField,text = note?.title ?? ""
            noteContentTextView.text = note?.content ?? ""
            basically if there isn't content then make the content the stuff after ??
        */
    }
}

