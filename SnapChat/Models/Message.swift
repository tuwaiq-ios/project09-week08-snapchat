//
//  Message.swift
//  SnapChat
//
//  Created by sara saud on 11/14/21.
//
import Foundation
import MessageKit
import UIKit
import CoreLocation


struct MessageKit: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}

struct SenderMKit: SenderType {
    var senderId: String
    var displayName: String
}

