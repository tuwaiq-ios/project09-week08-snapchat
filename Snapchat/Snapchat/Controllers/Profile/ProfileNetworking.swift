//
//  ProfileNetworking.swift
//  Snapchat
//
//  Created by Atheer Othman on 12/04/1443 AH.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth

class ProfileNetworking {
    
    var profileVC: ProfileViewController!
    
    init(_ profileVC: ProfileViewController) {
        self.profileVC = profileVC
    }
    
  

    
    func uploadImageToStorage(_ image: UIImage, completion: @escaping (_ imageUrl: URL?, _ error: Error?) -> Void) {
        let uniqueName = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("ProfileImages").child("\(uniqueName).jpg")
        if let uploadData = image.jpegData(compressionQuality: 0.1) {
            storageRef.putData(uploadData, metadata: nil) { (metaData, error) in
                if let error = error { return completion(nil, error) }
                storageRef.downloadURL { (url, error) in
                    if let error = error { return completion(nil, error) }
                    if let url = url { return completion(url, nil) }
                }
            }
        }
    }
    
    
    
    func updateCurrentUserInfo(_ url: URL) {
        Database.database().reference().child("users").child(User.id).updateChildValues(["profileImage":url.absoluteString]) { (error, databaseRef) in
            guard error == nil else { return }
            self.removeOldStorageImage()
            User.profileImage = url.absoluteString
           
        }
    }
    
  
    
    func removeOldStorageImage() {
        Storage.storage().reference(forURL: User.profileImage).delete { (error) in
            guard error == nil else { return }
        }
    }

}
