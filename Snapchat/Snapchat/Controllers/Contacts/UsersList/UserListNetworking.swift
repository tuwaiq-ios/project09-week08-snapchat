//
//  UserListNetworking.swift
//  Snapchat
//
//  Created by Fno Khalid on 10/04/1443 AH.
//

import UIKit
import FirebaseDatabase

class UserListNetworking {
    
    
    var userList = [String: FriendInfo]()
    
    
    func fetchUsers(completion: @escaping (_ userList: [String:FriendInfo]) -> Void){
        Database.database().reference().child("users").observeSingleEvent(of: .value) { (snap) in
            for child in snap.children {
                var user = FriendInfo()
                guard let snapshot = child as? DataSnapshot else { return }
                guard let values = snapshot.value as? [String: Any] else { return }
                user.email = values["email"] as? String
                user.profileImage = values["profileImage"] as? String
                user.name = values["name"] as? String
                user.id = snapshot.key
                if user.id != User.id && user.userCheck() {
                    self.userList[user.id!] = user
                }
            }
            return completion(self.userList)
        }
    }
    
}

