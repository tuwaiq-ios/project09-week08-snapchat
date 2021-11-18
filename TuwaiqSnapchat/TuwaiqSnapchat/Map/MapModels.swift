//
//  MapModels.swift
//  TuwaiqSnapchat
//
//  Created by HANAN on 13/04/1443 AH.
//

import UIKit

struct UserAnnotation: Decodable {
  var name: String
  var email: String
  var image: Data
  var location: Location
}
struct Location: Codable {
  var long: String
  var lat: String
}

