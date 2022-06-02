//
//  ViewController.swift
//  NewNoteApp
//
//  Created by Jack Lehavi on 5/23/22.
//

import UIKit
import CoreData

class NoteDisplayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var notes = [Note]()
    @IBOutlet weak var noteTableView : UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Create cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "noteTableViewCell", for: indexPath) as? noteTableViewCell else {
            fatalError()
        }
        
        //Access certain note from note array
        let note = notes[indexPath.row]
        
        //Add the note's text to the cell in tableview
        cell.contentLabel.text = note.text
        cell.titleLabel.text = note.title
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Moving to edit existing note
        let vc = storyboard?.instantiateViewController(withIdentifier: "NoteEditorViewController") as? NoteEditorViewController
        vc?.note = notes[indexPath.row]
        //Presenting note editor view controller
        show(vc!, sender: self)
    }
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Cheecking destination, then sending data chosen
        if let dest = segue.destination as? NoteEditorViewController {
            print("Peforming segue", notes[(noteTableView.indexPathForSelectedRow?.row)!])
            dest.note = notes[(noteTableView.indexPathForSelectedRow?.row)!]
        }
    }
     */
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Fetch request for notes
        
        if let x = fetchNotes() {
            notes = x
        }
        
        noteTableView.delegate = self
        noteTableView.dataSource = self
    }
    
    func fetchNotes() -> [Note]?{
        //Creating the fetch request
        let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
        var fetchResult : [Note]? = nil
        
        do {
            //Performing fetch request
            fetchResult = try DataContainer.shared.persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print("Unsuccessful Fetch Request")
        }

        return fetchResult
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }


}

