//
//  CoreDataHelper.swift
//  MakeSchoolNotes
//
//  Created by its on 19/7/2017.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataHelper {
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let persistentContainer = appDelegate.persistentContainer
    static let managedContext = persistentContainer.viewContext
    
    //Static methods
    static func newNote() -> Note{
        let note = NSEntityDescription.insertNewObject(forEntityName: "Note", into: managedContext)
        return note as! Note
    }
    
    static func saveNote() {
        do {
            try managedContext.save()
        } catch let error as NSError {
            print ("Could not save \(error)")
        }
    }
    
    static func deleteNote(note: Note) {
        managedContext.delete(note)
        saveNote()
    }
    
    static func retrieveNote() -> [Note] {
        let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
        do {
            let results = try managedContext.fetch(fetchRequest)
            return results
        } catch let error as NSError {
            print ("Could not fetch \(error)")
        }
        return []
    }
}
