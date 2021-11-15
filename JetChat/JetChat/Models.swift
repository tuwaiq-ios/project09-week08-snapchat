//
//  ViewController.swift
//  JetChat
//
//  Created by ibrahim asiri on 08/04/1443 AH.
//

import UIKit
import Foundation
import MessageKit
import CoreLocation

struct SenderMKit: SenderType {
    var senderId: String
    var displayName: String
}

struct MessageKit: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}

struct User {
    var id: String
    var name: String
    var status: String
    var userEmail: String
}










