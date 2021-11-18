//
//  Conversations.swift
//  SnapChat
//
//  Created by sara saud on 11/14/21.
//
import UIKit

//struct Conversations {
//    let id: String
//    let users:[User]
//    //title if we in group
//    let title: String
//
//}
struct Conversation {
    let id: String
    let name: String
    let otherUserEmail: String
    let title: String
    let latestMessage: LatestMessage
}

struct LatestMessage {
    let date: String
    let text: String
    let isRead: Bool
}
