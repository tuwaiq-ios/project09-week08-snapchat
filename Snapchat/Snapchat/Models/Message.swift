//
//  Message.swift
//  Snapchat
//
//  Created by dmdm on 12/11/2021.
//

import UIKit
import FirebaseFirestore

struct Message {
    let id: String
    let sender: String
    let receiver: String
    let content: String
    let timestamp: Timestamp
}
