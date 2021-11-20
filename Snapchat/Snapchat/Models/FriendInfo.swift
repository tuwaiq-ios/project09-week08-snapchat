//
//  UserInfo.swift
//  Snapchat
//
//  Created by Fno Khalid on 09/04/1443 AH.
//

import UIKit


// FRIEND MODEL

struct FriendInfo {
    
    var id: String?
    
    var name: String?
    
    var profileImage: String?
    
    var email: String?
    
    var isOnline: Bool?
    
    var lastLogin: NSNumber?
    
    var isMapLocationEnabled: Bool?
    
    func userCheck() -> Bool{
        if id == nil || name == nil || profileImage == nil, email == nil{
            return false
        }
        return true
    }
}

class Friends {
    
    static var list = [FriendInfo]()
    
    static var convVC: ConversationViewController?
}

struct FriendActivity{
    
    let isTyping: Bool?
    
    let friendId: String?
    
    init(isTyping: Bool, friendId: String) {
        
        self.isTyping = isTyping
        self.friendId = friendId
        
    }
    
}
