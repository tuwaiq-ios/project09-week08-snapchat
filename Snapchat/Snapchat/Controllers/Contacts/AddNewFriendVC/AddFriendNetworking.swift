//
//  AddFriendNetworking.swift
//  Snapchat
//
//  Created by Fno Khalid on 10/04/1443 AH.
//


import UIKit
import FirebaseDatabase
import FirebaseAuth


class AddFriendNetworking {
    
    var friend: FriendInfo!
    var controller: AddFriendVC!
    
    
    func addAsFriend() {
        let ref = Database.database().reference().child("friendsList").child("friendRequests").child(friend.id ?? "").child(User.id).child(User.id)
        ref.setValue(User.id)
    }
    
    func removeFriend() {
        let userRef = Database.database().reference().child("friendsList").child(User.id).child(friend.id ?? "").child(friend.id ?? "")
        let friendRef = Database.database().reference().child("friendsList").child(friend.id ?? "").child(User.id).child(User.id)
        userRef.removeValue()
        friendRef.removeValue()
    }
    
    func checkFriend(){
        checkForFriendRequest {
            self.checkFriendship()
        }
    }
    
    func removeFriendRequest() {
        Database.database().reference().child("friendsList").child("friendRequests").child(friend.id ?? "").child(User.id).child(User.id).removeValue()
    }
    
    
    func checkFriendship() {
        Database.database().reference().child("friendsList").child(User.id).child(friend.id ?? "").observe(.value) { (snapshot) in
            self.controller.addButton.isHidden = false
            self.controller.loadingIndicator.stopAnimating()
            guard let values = snapshot.value as? [String: Any] else {
                self.controller.addButton.setTitle("Add Friend", for: .normal)
                self.controller.addButton.layer.insertSublayer(self.controller.greenGradientLayer, at: 0)
                self.controller.redGradientLayer.removeFromSuperlayer()
                self.controller.grayGradientLayer.removeFromSuperlayer()
                return
            }
            let f = values
            if f[self.friend.id ?? ""] as? Bool != nil && f[self.friend.id ?? ""] as? Bool == true {
                self.controller.greenGradientLayer.removeFromSuperlayer()
                self.controller.grayGradientLayer.removeFromSuperlayer()
                self.controller.addButton.layer.insertSublayer(self.controller.redGradientLayer, at: 0)
                self.controller.addButton.setTitle("Remove Friend", for: .normal)
            }
        }
    }

    
    func checkForFriendRequest(completion: @escaping () -> Void) {
        Database.database().reference().child("friendsList").child("friendRequests").child(friend.id ?? "").child(User.id).observeSingleEvent(of: .value) { (snap) in
            guard let _ = snap.value as? [String: Any] else { return completion() }
            self.controller.addButton.setTitle("Requested", for: .normal)
            self.controller.addButton.isHidden = false
            self.controller.loadingIndicator.stopAnimating()
            self.controller.redGradientLayer.removeFromSuperlayer()
            self.controller.greenGradientLayer.removeFromSuperlayer()
            self.controller.addButton.layer.insertSublayer(self.controller.grayGradientLayer, at: 0)
        }
    }

    
}
