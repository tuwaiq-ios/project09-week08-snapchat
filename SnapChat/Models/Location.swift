//
//  Location.swift
//  SnapChat
//
//  Created by sara saud on 11/14/21.
//

import Foundation

import UIKit
import FirebaseFirestore
// add struct Location
struct Location {
    let id: String
    let userId: String
    let location: String
 
}
// Location_struct from fawaz

import UIKit
import Firebase
import Foundation
import FirebaseFirestore
import CoreLocation

struct Location_struct {
  var id: String
  var location: CLLocation
  var size: CGSize
}

