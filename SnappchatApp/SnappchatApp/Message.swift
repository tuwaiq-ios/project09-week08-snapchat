//
//  Message.swift
//  SnappchatApp
//
//  Created by dmdm on 14/11/2021.
//

import UIKit
import Firebase

class Message: NSObject {

    var fromId: String?
    var text: String?
    
    var timestamp: NSNumber?
    var toId: String?
    var id: String?
    //var sender:String?
   // var reciver:String?
   // var content:String?
   // var timestamp: timestamp?
    
    init(dictionary: [String: Any]) {
        self.fromId = dictionary["fromId"] as? String
        self.text = dictionary["text"] as? String
        self.toId = dictionary["toId"] as? String
        self.timestamp = dictionary["timestamp"] as? NSNumber
    }
    
    func chatPartnerId() -> String? {
        return fromId == Auth.auth().currentUser?.uid ? toId : fromId
    }
    
}
