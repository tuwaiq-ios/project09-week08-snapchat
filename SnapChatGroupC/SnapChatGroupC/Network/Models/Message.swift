//
//  Message.swift
//  SnapChatGroupC
//
//  Created by sara al zhrani on 07/04/1443 AH.
//

import UIKit
import FirebaseFirestore

struct Message {
    let id: String
    let sender: String
    let receiver: String
    let content: String?
    let convId :String
    // let timestamp: Timestamp
    let senderId:String
    let receiverName: String
    let senderName:String
}

