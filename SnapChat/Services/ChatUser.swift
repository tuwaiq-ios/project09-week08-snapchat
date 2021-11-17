//
//  jjjj.swift
//  SnapChat
//
//  Created by Amal on 11/04/1443 AH.
//

import Foundation
import FirebaseFirestore


let db = Firestore.firestore()


func saveUserToFirestore(name: String, email: String) {
    let doc = ["id": "1", "name": name, "email": email, "status": "1" ]
    db.collection("users").addDocument(data: doc)
}


func getUsers(completion: @escaping([User])->()) {
    db.collection("users").getDocuments { (snapshot, err) in
        if let error = err {
            print("error getting documents \(error)")
        } else {
            var users:[User] = []
            for document in snapshot!.documents {
                let docId = document.documentID
                let name = document.get("name") as? String ?? ""
                let id = document.get("id") as? String ?? ""
                let status = document.get("status") as? String ?? ""
                let image = document.get("image") as? String ?? ""
                let email = document.get("email") as? String ?? ""
                let location = document.get("location") as? String ?? ""

                
                let user = User(id: id, name: name, status: status, image: image, userEmail: email, location: location)

                users.append(user)
            }
            completion(users)
        }
        
    }
}
