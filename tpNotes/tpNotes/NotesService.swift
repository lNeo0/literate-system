//
//  NotesService.swift
//  tpNotes
//
//  Created by Maxime Consigny on 13/06/2021.
//

import Foundation
import Alamofire


class NotesService {

    public var notes : [Note] = []
    let baseURL = "http://localhost:8080/"
    
    let decoder = CustomDecoder()
    let encoder = JSONParameterEncoder(encoder: CustomEncoder())
    
    func load(_ handler: @escaping ((Bool) -> Void)) {
        AF.request("\(baseURL)notes")
                    .responseDecodable(of: [Note].self,
                                       decoder: self.decoder as! DataDecoder,
                    completionHandler: { response in
                        switch response.result {
                        case let .success(data):
                            self.notes = data 
                            handler(true)
                        case let .failure(error):
                            print(error.localizedDescription)
                            handler(false)
                        }
                    })
            }

    func findByIndex(_ index: Int) -> Note {
        return notes[index]
    }
    
    func count() -> Int {
                   return notes.count
    }
    
   func add(note: Note) {
    let request = AF.request("\(baseURL)notes",
                             method: .post,
                             parameters: note,
                             encoder: encoder)
          request.response { response in
              debugPrint(response)
    }
   }
    
   func update(note: Note) {
    let request = AF.request("\(baseURL)notes",
                             method: .put,
                             parameters: note,
                             encoder: encoder)
          request.response { response in
              debugPrint(response)
    }
   }
    
   func remove(at index: Int, handler: @escaping ((Bool) -> Void)) {
    let request = AF.request("\(baseURL)notes/\(notes[index].id!)", method: .delete)
    request.response { response in
              switch response.result {
              case .success(_):
                self.notes.remove(at: index)
                print("Supp success")
                handler(true)
              case .failure(_):
                print("Supp echec")
                handler(false)
              }
    }
   }
    
}
