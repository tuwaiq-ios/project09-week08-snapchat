//
//  MessagesService.swift
//  SnapChatGroupC
//
//  Created by sara al zhrani on 07/04/1443 AH.
//
import UIKit
import Firebase
import FirebaseFirestore


class MessagesService {
    static let shared = MessagesService()
    
    let messagesCollection = Firestore.firestore().collection("messages")
    
    
    
    
 //listen to conversation
    
    func listenToConversation(
        userId1: String,
        userId2: String,
        completion: @escaping (([Message]) -> Void)
    ) {
        var messages = [Message]()
        
        messagesCollection
            .whereField("sender", isEqualTo: userId2)
            .whereField("receiver", isEqualTo: userId1)
            .addSnapshotListener  { snapshot, error in
                if error != nil {
                    return
                }
                
                guard let docs = snapshot?.documents else {
                    return
                }
                
                for doc in docs {
                    let date = doc.data()
                    guard
                        let id = date["id"] as? String,
                        let content = date["content"] as? String,
                        let sender = date["sender"] as? String,
                        let receiver = date["receiver"] as? String
//                        let timestamp = date["timestamp"] as? Timestamp
                    else {
                            continue
                        }
                    
                    let newMessage = Message(id: id, sender: sender, receiver: receiver, content: content)
                    
                    if messages.contains(where: { message in
                        message.id == newMessage.id
                    }) {
                        continue
                    }
                    
                    messages.append(newMessage)
                }
                completion(messages)
                
            }
        
        messagesCollection
            .whereField("sender", isEqualTo: userId1)
            .whereField("receiver", isEqualTo: userId2)
            .addSnapshotListener { snapshot, error in
                if error != nil {
                    return
                }
                
                guard let docs = snapshot?.documents else {
                    return
                }
                
                for doc in docs {
                    let date = doc.data()
                    guard
                        let id = date["id"] as? String,
                        let content = date["content"] as? String,
                        let sender = date["sender"] as? String,
                        let receiver = date["receiver"] as? String
//                        let timestamp = date["timestamp"] as? Timestamp
                    else {
                            continue
                        }
                    
                    let newMessage = Message(id: id, sender: sender, receiver: receiver, content: content)
                    
                    if messages.contains(where: { message in
                        message.id == newMessage.id
                    }) {
                        continue
                    }
                    
                    messages.append(newMessage)
                }
                completion(messages)
            }
        
    }
    
    
    ///// sending Messag
    func sendMessage(message: Message) {
        messagesCollection.document(message.id).setData([
            "id": message.id,
            "content": message.content,
            "receiver": message.receiver,
//            "timestamp": message.timestamp
        ])
    }
   
    }
    
    
    
    

