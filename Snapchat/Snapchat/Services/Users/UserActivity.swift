//
//  UserActivity.swift
//  Snapchat
//
//  Created by Eth Os on 08/04/1443 AH.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase


class UserActivity {
    
    static func observe(isOnline: Bool) {
        
        guard let user = Auth.auth().currentUser else { return }
        let ref = Database.database().reference()
        let userRef = ref.child("users").child(user.uid)
        userRef.child("isOnline").setValue(isOnline)
        userRef.child("lastLogin").setValue(Date().timeIntervalSince1970)
        
    }
    
}
