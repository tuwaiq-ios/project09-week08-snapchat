//
//  Message.swift
//  snapchatt
//
//  Created by sally asiri on 10/04/1443 AH.
//

import UIKit
import FirebaseFirestore
// add struct Message
struct Message {
    let id: String
    let senderId: String
    let senderName: String
    let content: String
    let timestamp: Timestamp
    let conversationsId : String
}
