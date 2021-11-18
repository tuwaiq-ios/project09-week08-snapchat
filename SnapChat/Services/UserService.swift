//
//  UserServies.swift
//  SnapChat
//
//  Created by Amal on 13/04/1443 AH.
//

import UIKit



//
//guard let curruntUserId = Auth.auth().currentUser?.uid else { return }
//let users = conversation?.users ?? []
//let otherUserId = users.first { id in
//    id != curruntUserId
//} ?? ""
//
//
//Firestore.firestore().collection("users").document(otherUserId).addSnapshotListener { doc, error in
//    guard let data = doc?.data() else { return }
//    let otherUser = User(id: data["id"] as! String,
//                         name: data["name"] as! String,
//                         status: data["status"] as! String,
//                         image: data["image"] as! String,
//                         location: data["location"] as! String)
//    self.user = otherUser
//    self.title = otherUser.name
//}
//
//let messageId = UUID().uuidString
//guard let currentUserID = Auth.auth().currentUser?.uid else {return}
//guard let message = messageTextField.text else {return}
////        guard let user = user else {return}
//
//Firestore.firestore().document("messages/\(messageId)").setData([
//    "id" : UUID().uuidString,
//    "senderId" : currentUserID,
//    "senderName": "",
//    "content" : message,
//    "timestamp":  Timestamp(),
//    "conversationsId" : conversation?.id
//    
//])
//messageTextField.text = ""
