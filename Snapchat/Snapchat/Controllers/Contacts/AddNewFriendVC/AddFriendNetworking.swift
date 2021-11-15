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
        guard let userId = Auth.auth().currentUser?.uid else {return}
        let ref = Database.database().reference().child("friendsList").child("friendRequests").child(friend.id ?? "").child(userId).child(userId)
        ref.setValue(userId)
    }
    
    func removeFriend() {
        guard let userId = Auth.auth().currentUser?.uid else {return}
        let userRef = Database.database().reference().child("friendsList").child(userId).child(friend.id ?? "").child(friend.id ?? "")
        let friendRef = Database.database().reference().child("friendsList").child(friend.id ?? "").child(userId).child(userId)
        userRef.removeValue()
        friendRef.removeValue()
    }
    
    func checkFriend(){
        checkForFriendRequest {
            self.checkFriendship()
        }
    }
    
    func removeFriendRequest() {
        guard let userId = Auth.auth().currentUser?.uid else {return}
        Database.database().reference().child("friendsList").child("friendRequests").child(friend.id ?? "").child(userId).child(userId).removeValue()
    }
    
    
    func checkFriendship() {
        guard let userId = Auth.auth().currentUser?.uid else {return}
        Database.database().reference().child("friendsList").child(userId).child(friend.id ?? "").observe(.value) { (snapshot) in
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
        guard let userId = Auth.auth().currentUser?.uid else {return}
        Database.database().reference().child("friendsList").child("friendRequests").child(friend.id ?? "").child(userId).observeSingleEvent(of: .value) { (snap) in
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
