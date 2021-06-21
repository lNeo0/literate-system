//
//  JSONDecoder.swift
//  tpNotes
//
//  Created by Maxime Consigny on 13/06/2021.
//

import Foundation

class CustomDecoder: JSONDecoder {
          override init() {
              super.init()
              dateDecodingStrategy = .iso8601
          }
}
