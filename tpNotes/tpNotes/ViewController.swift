//
//  ViewController.swift
//  tpNotes
//
//  Created by Maxime Consigny on 13/06/2021.
//

import UIKit

class ViewController: UITableViewController {

    var noteService : NotesService = NotesService()
    
    @IBOutlet var affichage: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string:"Rafraîchissement ...")
        refreshControl?.addTarget(self, action: #selector(loadNotes), for: .valueChanged)
        loadNotes()
    }
    
    @objc func loadNotes(){
        noteService.load({resultat in if resultat{
            self.affichage.reloadData()
            self.refreshControl?.endRefreshing()
        }})
    }
    
    struct NoteCellule {
        var title : String
        var createdAt : Date
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteService.notes.count
        }
    
    override func tableView(_ tableView: UITableView, cellForRowAt
    indexPath: IndexPath) -> UITableViewCell {
        
        let cellule = tableView.dequeueReusableCell(
            withIdentifier: "celluleNote",
            for: indexPath)
        
        let noteCellule = noteService.notes[indexPath.row]
        
        let date       = DateFormatter()
        date.dateStyle = .medium
        date.timeStyle = .medium
        date.locale    = Locale(identifier: "fr_FR")
        
        cellule.textLabel?.text = noteCellule.title
        cellule.detailTextLabel?.text = "Créé le \(date.string(from: noteCellule.createdAt))"
        
            return cellule
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           guard let controller = segue.destination as? FormViewController
                 else { return }
            controller.saveCallback = { toBeSaved in
                if toBeSaved.id != nil {
                    self.noteService.update(note: toBeSaved)
                } else {
                    self.noteService.add(note: toBeSaved)
                }
                self.tableView.reloadData()
            }
            if let indexPath = tableView.indexPathForSelectedRow {
                controller.note = noteService.findByIndex(indexPath.row)
            } else {
                controller.note = Note(title: "", content: "")
            }
    }
    
    
    override func tableView(_ tableView: UITableView,
    canEditRowAt indexPath: IndexPath) -> Bool {
    true
    }
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) ->
    UISwipeActionsConfiguration? {
               let deleteAction = UIContextualAction(style: .destructive, title: "Supprimer") {
                    (contextAction: UIContextualAction,
                     sourceView: UIView,
                     completionHandler: @escaping (Bool) -> Void) in
                   self.noteService.remove(at: indexPath.row) { success in
                       completionHandler(success)
                       if success {
                           tableView.deleteRows(at: [indexPath], with: .fade)
                       }
                   }
               }
               return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}

