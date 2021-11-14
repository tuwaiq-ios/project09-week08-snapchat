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
    let receiver: String
    let content: String
    let timestamp: Timestamp
}
