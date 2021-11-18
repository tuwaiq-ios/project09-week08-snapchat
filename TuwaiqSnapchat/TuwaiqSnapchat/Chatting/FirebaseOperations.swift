//
//  FirebaseOperations.swift
//  TuwaiqSnapchat
//
//  Created by HANAN on 13/04/1443 AH.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth
let db = Firestore.firestore()
func saveUserToFirestore(uuid: String, name: String, email: String) {
  let doc = ["uuid": uuid, "id": uuid, "name": name, "email": email, "status": "1" ]
  db.collection("users").document(uuid).setData(doc)
}
func saveUserImageToFirebase(uuid: String, url: String) {
  db.collection("users").document(uuid).updateData(["avatar": url])
}
func getCurrentUserFromFirestore(completion: @escaping(User)->()) {
  let docRef = db.collection("users").document(Auth.auth().currentUser?.uid ?? "")
  docRef.getDocument { (document, error) in
    if let document = document, document.exists {
//      let uuid = document.get("uuid") as? String
      let name = document.get("name") as? String
      let email = document.get("email") as? String
      let id = document.get("id") as? String
      let status = document.get("name") as? String
      let avatar = document.get("avatar") as? String
      let user = User(id: id, name: name, status: status, userEmail: email, avatar: avatar)
      completion(user)
    } else {
      print("Document does not exist")
    }
  }
}
func getUsers(completion: @escaping([User])->()) {
  db.collection("users").getDocuments { (snapshot, err) in
    if let error = err {
      print("error getting documents \(error)")
    } else {
      var users:[User] = []
      for document in snapshot!.documents {
        let docId = document.documentID
        let name = document.get("name") as! String
        let id = document.get("id") as! String
        let status = document.get("status") as! String
        let email = document.get("email") as! String
        let user = User(id: id, name: name, status: status, userEmail: email)
        users.append(user)
      }
      completion(users)
    }
  }
}
func uploadAvatar(image: UIImage, completion: @escaping (_ url: String?) -> Void) {
  let storageRef = Storage.storage().reference().child("avatar.png")
  if let uploadData = image.jpegData(compressionQuality: 0.6){
    storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
      if error != nil {
        print("error")
        completion(nil)
      } else {
        storageRef.downloadURL(completion: { (url, error) in
          print(url?.absoluteString)
          completion(url?.absoluteString)
        })
      }
    }
  }
}

