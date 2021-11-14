//
//  Messages.swift
//  Snapchat
//
//  Created by Fno Khalid on 08/04/1443 AH.
//

import UIKit

class Messages {
    
    var message: String!
    var sender: String!
    var receiver: String!
    var time: NSNumber!
    var mediaUrl: String!
    var videoUrl: String!
    var storageID: String!
    var imageWidth: NSNumber!
    var imageHeight: NSNumber!
    var id: String!
    var repMID: String!
    var repMessage: String!
    var repMediaMessage: String!
    var repSender: String!
    
    
    func determineUser() -> String {
        if sender == User.uid {
            return receiver
        } else {
            return sender
        }
    }
    
}
