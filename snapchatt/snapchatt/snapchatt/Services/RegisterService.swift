//
//  RegisterService.swift
//  snapchatt
//
//  Created by Hassan Yahya on 10/04/1443 AH.
//
import UIKit
import FirebaseFirestore

class RegisterService {
	
	static let shared = RegisterService()
	
	let usersCollection = Firestore.firestore().collection("users")
	
	// Add user to firestor
	func addUser(user: User) {
		usersCollection.document(user.id).setData([
			"name": user.name,
			"id": user.id,
			"image": user.image,
			"status": user.status,
			"location" : user.location
		])
	}
	
	func listenToUsers(completion: @escaping (([User]) -> Void)) {
		
		usersCollection.addSnapshotListener { snapshot, error in
            if error != nil { // if there's any error
				return
			}
			guard let documents = snapshot?.documents else { return }
			
			var users: Array<User> = []
			for document in documents {
				let data = document.data()
				let user = User(
					id: (data["id"] as? String) ?? "No id",
					name: (data["name"] as? String) ?? "No name",
					status: (data["status"] as? String ?? "No status"),
					image: (data["image"] as? String ?? "No image"),
					location: (data["status"] as? String ?? "No status")
				)
				users.append(user)
			}
			
			completion(users)
		}
	}
	func updateUserInfo(user: User) {
		usersCollection.document(user.id).setData([
			"id": user.id,
			"name": user.name,
			"image": user.image,
			"status": user.status,
		], merge: true)
	}

}
