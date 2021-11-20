//
//  FriendRequestNetworking .swift
//  Snapchat
//
//  Created by Fno Khalid on 10/04/1443 AH.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class FriendRequestNetworking {
    
  
    var controller: FriendRequestVC!
    var friendKeys = [String]()
    var groupedUsers = [String:FriendInfo]()
    
    
    private func loadRequests(completion: @escaping() -> Void) {
        Database.database().reference().child("friendsList").child("friendRequests").child(User.id).observeSingleEvent(of: .value) { (snap) in
            self.controller.blankLoadingView.isHidden = true
            guard let values = snap.value as? [String:Any] else { return completion() }
            self.friendKeys.append(contentsOf: Array(values.keys))
            return completion()
        }
    }
    
    
    func setupFriendRequests(_ completion: @escaping () -> Void) {
        loadRequests {
            if self.friendKeys.count == 0 { return completion() }
            self.fetchUsers()
        }
        
    }

    
    private func fetchUsers() {
        for key in friendKeys {
            Database.database().reference().child("users").child(key).observeSingleEvent(of: .value) { (snap) in
                guard let values = snap.value as? [String: Any] else { return }
                self.setupFriendInfo(for: key, values)
                self.controller.friendRequests = Array(self.groupedUsers.values)
                self.controller.friendRequests.sort { (friend1, friend2) -> Bool in
                    return friend1.name ?? "" < friend2.name ?? ""
                }
                self.controller.tableView.reloadData()
            }
        }
    }
    
    
    private func setupFriendInfo(for key: String, _ values: [String: Any]){
        var friend = FriendInfo()
        friend.id = key
        friend.email = values["email"] as? String
        friend.profileImage = values["profileImage"] as? String
        friend.name = values["name"] as? String
        friend.isOnline = values["isOnline"] as? Bool
        friend.lastLogin = values["lastLogin"] as? NSNumber
        friend.isMapLocationEnabled = values["isMapLocationEnabled"] as? Bool
        groupedUsers[key] = friend
    }
    
    
    func addAsFriend(_ friend: FriendInfo, completion: @escaping () -> Void) {
        guard let id = friend.id else { return }
        let userRef = Database.database().reference().child("friendsList").child(User.id).child(id).child(id)
        let friendRef = Database.database().reference().child("friendsList").child(id).child(User.id).child(User.id)
        userRef.setValue(true)
        friendRef.setValue(true)
        self.removeRequestFromDB(friend) {
            return completion()
        }
    }
    

    
    func declineUser(_ userToDelete: FriendInfo, completion: @escaping() -> Void) {
        self.removeRequestFromDB(userToDelete) {
            return completion()
        }
    }

    
    private func removeRequestFromDB(_ user: FriendInfo, completion: @escaping () -> Void) {
        
        self.groupedUsers.removeValue(forKey: user.id ?? "")
        Database.database().reference().child("friendsList").child("friendRequests").child(User.id).child(user.id ?? "").child(user.id ?? "").removeValue { (error, ref) in
            Database.database().reference().child("friendsList").child("friendRequests").child(user.id ?? "").child(User.id).child(User.id).removeValue()
            return completion()
        }
    }
    
    
}

