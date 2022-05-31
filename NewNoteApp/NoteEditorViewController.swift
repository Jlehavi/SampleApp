//
//  SecondViewController.swift
//  NewNoteApp
//
//  Created by Jack Lehavi on 5/25/22.
//

import UIKit
import CoreData

class NoteEditorViewController: UIViewController {

    @IBOutlet weak var noteInput: UITextView!
    @IBOutlet weak var titleInput : UITextView!
    
    var note: Note?
    
    @IBAction func saveNote(_ sender: UIButton) {
        if let note = note {
            //Updating Existing Note
            note.text = noteInput.text
            note.title = titleInput.text
        } else {
            //New Note Created
            note = Note(context: DataContainer.shared.persistentContainer.viewContext)
            
            note!.text = noteInput.text
            note!.title = titleInput.text
            
        }
        
        DataContainer.shared.saveContext()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
