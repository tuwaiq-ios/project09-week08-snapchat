//
//  Messages.swift
//  Snapchat
//
//  Created by Fno Khalid on 09/04/1443 AH.
//

import UIKit


class Messages {
    
    var message: String!
    var sender: String!
    var recipient: String!
    var time: NSNumber!
    var mediaUrl: String!
    var audioUrl: String!
    var videoUrl: String!
    var storageID: String!
    var imageWidth: NSNumber!
    var imageHeight: NSNumber!
    var id: String!
    var repMessage: String!
    var repMediaMessage: String!
    var repMID: String!
    var repSender: String!
    
    func determineUser() -> String{
        if sender == User.id{
            return recipient
        }else{
            return sender
        }
    }
}

