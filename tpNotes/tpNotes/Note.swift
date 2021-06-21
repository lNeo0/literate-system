//
//  Note.swift
//  tpNotes
//
//  Created by Maxime Consigny on 13/06/2021.
//

import Foundation

class Note: Codable {
    var id: Int?
    var title: String
    var content: String
    var createdAt: Date
    var updatedAt: Date?
    
    init(title : String, content : String){
        self.title = title
        self.content = content
        self.createdAt = Date.init()
    }
}
