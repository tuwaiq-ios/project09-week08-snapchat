//
//  UserActivity.swift
//  Snapchat
//
//  Created by Eth Os on 08/04/1443 AH.
//

import UIKit
import Firebase

class UserActivity {
    
    static func listen(isOnline: Bool){
        
        guard let user = Auth.auth().currentUser else { return }
        let ref = Firestore.firestore().collection("users")
        let userRef = ref.document(user.uid)
        userRef.setData([
            "isOnline": isOnline,
            "lastLogin": Date().timeIntervalSince1970
        ])
    }
    
}
