//
//  Chat.swift
//  JetChat
//
//  Created by ibrahim asiri on 11/04/1443 AH.
//

import Foundation
import MessageKit


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
