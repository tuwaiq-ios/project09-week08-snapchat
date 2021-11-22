//
//  Model.swift
//  TuwaiqChat
//
//  Created by PC on 09/04/1443 AH.
//

import UIKit

struct User {
    var id : String?
    var name : String?
    var email : String?
    var profileImage : String?
    var lat : Double?
    var long : Double?
}


struct Message {
    var id : String?
    var content : String?
    var sender : String?
    var reciever : String?
    var hasLocation : Bool?
}
