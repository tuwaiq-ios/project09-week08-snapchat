//
//  Message.swift
//  SnnapChatApp
//
//  Created by dmdm on 15/11/2021.
//

import Foundation
import Firebase

struct Message {
    let content : String?
    let sender : String?
    let reciever : String?
    let id : String
    let timestamp : Timestamp?
}
