//
//  Message.swift
//  snapchatt
//
//  Created by sally asiri on 10/04/1443 AH.
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
//
//struct Message {
//	let content : String?
//	let sender : String?
//	let reciever : String?
//	let id : String
//	let timestamp : Timestamp?
//}
