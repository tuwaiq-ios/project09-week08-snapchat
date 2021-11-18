//
//  Message.swift
//  SnapChat
//
//  Created by sara saud on 11/14/21.
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

