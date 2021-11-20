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
    
    func getAllConversation(completion: @escaping (([Conversation]) -> Void)) {
        var conversation = [Conversation]()
        messagesCollection.addSnapshotListener { data, error in
            guard error == nil else { return }
            guard let docs = data?.documents else { return }
            for doc in docs {
                let newData = doc.data()
                print(newData)
                let id = newData["id"] as? String
                let content = newData["content"] as? String
                let receiver = newData["receiver"] as? String ?? ""
                let reciverId = newData["reciverId"] as? String ?? ""
                let sender = newData["sender"] as? String
                let timestamp = newData["timestamp"] as? Timestamp
                let convId = newData["convId"] as? String
                let senderId = newData["senderId"] as? String
                let receiverName = newData["receiverName"] as? String
                let senderName = newData["senderName"] as? String
                let newConversation = Conversation(conersationId: convId ?? "", senderId: sender ?? "", messageId: id ?? "", title: content ?? "", usersIds: [receiverName ?? "",senderName ?? ""], reciverId: receiver)
                conversation.append(newConversation)
            }
            completion(conversation)
        }
    }
    
    
    
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
                    
                    let id = date["id"] as? String
                    let content = date["content"] as? String ?? ""
                    let sender = date["sender"] as? String ?? ""
                    let receiver = date["receiver"] as? String ?? ""
                    // let timestamp = date["timestamp"] as? Timestamp
                    let convId = date["convId"] as? String ?? ""
                    let receiverName = date["receiverName"] as? String ?? ""
                    let senderName = date["senderName"] as? String ?? ""
                    
                    let newMessage = Message(id: id ?? "", sender: sender, receiver: receiver, content: content, convId: convId, senderId: userId2,receiverName: receiverName,senderName:senderName)
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
                    
                    let id = date["id"] as? String ?? ""
                    let content = date["content"] as? String ?? ""
                    let sender = date["sender"] as? String ?? ""
                    let receiver = date["receiver"] as? String ?? ""
                    
                    let convId = date["convId"] as? String ?? ""
                    let senderId = date["senderId"] as? String ?? ""
                    let receiverName = date["receiverName"] as? String ?? ""
                    let senderName = date["senderName"] as? String ?? ""
                    
                    let newMessage = Message(id: id , sender: sender, receiver: receiver, content: content, convId: convId, senderId: userId2,receiverName: receiverName,senderName:senderName)
                    
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
            "sender": message.sender,
            "receiver": message.receiver,
            "convId":message.convId,
            "senderId":message.senderId,
            "receiverName":message.receiverName,
            "senderName":message.senderName
        ])
    }
    
}





