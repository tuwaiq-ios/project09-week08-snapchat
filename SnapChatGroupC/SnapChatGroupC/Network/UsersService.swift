//
//  UsersService.swift
//  SnapChatGroupC
//
//  Created by sara al zhrani on 07/04/1443 AH.
//

import UIKit
import FirebaseFirestore


class UsersService {
    static let shared = UsersService()
    
    let usersCollection = Firestore.firestore().collection("users")
    
    func listenToUsers(completion: @escaping (([User]) -> Void)) {
        
        usersCollection.addSnapshotListener { snapshot, error in
            if error != nil {
                return
            }
            
            guard let docs = snapshot?.documents else {
                return
            }
            
            var users: [User] = []
            for doc in docs {
                let data = doc.data()
                guard
                    let id = data["id"] as? String,
                    let name = data["name"] as? String,
                    let status = data["status"] as? String
//                    let image = data["image"] as? String

                else  {
                        continue
                    }
                
                let latitude = data["latitude"] as? Double
                let longitude = data["longitude"] as? Double
                
                let user = User(
                    id: id,
                    name: name,
                    status: status,
                    latitude: latitude ?? 00,
                    longitude: longitude ?? 00)
                
                users.append(user)
            }
            
            completion(users)
        }
    }
    
    func updateUserInfo(user: User) {
        usersCollection.document(user.id).setData([
            "id": user.id,
            "name": user.name,
            "status": user.status,
//            "image" : user.image,
            "latitude": 0.0,
            "longitude": 0.0,
        ], merge: true)
    }
}
