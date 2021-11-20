//
//  ForwardToSend + Protocol.swift
//  Snapchat
//
//  Created by Fno Khalid on 10/04/1443 AH.
//

import UIKit


protocol ForwardToFriend {
    
    func forwardToSelectedFriend(friend: FriendInfo, for name: String)
    
}

extension ChatViewController: ForwardToFriend {
    
    
    func forwardToSelectedFriend(friend: FriendInfo, for name: String) {
        responseButtonPressed(userResponse.messageToForward!, forwardedName: name)
        self.friend = friend
        messages = []
        collectionView.reloadData()
        setupChat()
    }


    
}
