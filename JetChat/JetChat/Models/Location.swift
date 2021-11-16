//
//  Location.swift
//  JetChat
//
//  Created by ibrahim asiri on 11/04/1443 AH.
//

import Foundation
import CoreLocation
import MessageKit

struct LocationMKit: LocationItem{
    var location: CLLocation
    var size: CGSize
}

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


