//
//  Message.swift
//  snapchat_app
//
//  Created by dmdm on 18/11/2021.
//

import UIKit
import FirebaseFirestore

struct Message {
    let id: String
    let senderId: String
    let senderName: String
    let content: String
    let timestamp: Timestamp
    let conversationsId : String
}
