//
//  NewConvSelectedProtocol + Extension.swift
//  Snapchat
//
//  Created by Fno Khalid on 10/04/1443 AH.
//

import UIKit

protocol NewConversationSelected {
    func showSelectedUser(selectedFriend: FriendInfo)
}

extension ConversationViewController: NewConversationSelected {
    
 
    
    func showSelectedUser(selectedFriend: FriendInfo) {
        nextControllerHandler(usr: selectedFriend)
    }
    
}

