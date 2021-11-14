//
//  ConversationsNetworking.swift
//  Snapchat
//
//  Created by Fno Khalid on 08/04/1443 AH.
//

import UIKit
import Firebase

class ConversationsNetworking {
    
    var convVC: ContactsViewController!
    var groupedMessages = [String: Messages]()
    var unreadMessages = [String: Int]()
    var friendKeys = [String]()
    var totalUnread = Int()
}
