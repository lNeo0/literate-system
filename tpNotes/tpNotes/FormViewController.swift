//
//  FormViewController.swift
//  tpNotes
//
//  Created by Maxime Consigny on 13/06/2021.
//

import Foundation
import UIKit

class FormViewController: UIViewController{


    @IBOutlet weak var titreNote: UITextField!
    
    @IBOutlet weak var contenuNote: UITextView!
    
    @IBAction func enregistrer(_ sender: UIBarButtonItem) {
        note?.title = titreNote.text!
        note?.content = contenuNote.text
        saveCallback!(note!)
        note = nil
        saveCallback = nil
        navigationController?.popViewController(animated: true)
    }
    
    var saveCallback: ((Note) -> Void)?
    
    var note: Note?
    
    
    @IBOutlet var Controller: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if note?.content != nil {
            contenuNote.text = note?.content
            titreNote.text = note?.title
        }
    }
    
}
