//
//  JSONEncoder.swift
//  tpNotes
//
//  Created by Maxime Consigny on 13/06/2021.
//

import Foundation

class CustomEncoder: JSONEncoder {
          override init() {
              super.init()
              dateEncodingStrategy = .iso8601
          }
}
