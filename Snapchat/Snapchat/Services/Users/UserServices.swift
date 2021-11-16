//
//  UserServices.swift
//  Snapchat
//
//  Created by Eth Os on 08/04/1443 AH.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class UserServices{
    
    var mainController: UIViewController!
    
    var networkingLoadingIndicator = NetworkingLoadingIndicator()
    
    init(_ mainController: UIViewController?){
        self.mainController = mainController
    }
    
    
    // MARK: SignIn Method
    
    func signIn(with email: String, and pass: String, completion: @escaping (_ error: Error?) -> Void){
        networkingLoadingIndicator.startLoadingAnimation()
        Auth.auth().signIn(withEmail: email, password: pass) { authResult, error in
            if let error = error {
                self.networkingLoadingIndicator.endLoadingAnimation()
                return completion(error)
            }else{
                self.nextController()
            }
        }
    }
    
    func nextController(){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        setupUserInfo(uid) { (isActive) in
            if isActive{
                let controller = TabViewController()
                controller.modalPresentationStyle = .fullScreen
                self.mainController.present(controller, animated: false, completion: nil)
                self.networkingLoadingIndicator.endLoadingAnimation()
            }
        }
    }
    
    
    // MARK: Setup User Info Method
    func setupUserInfo(_ uid: String, completion: @escaping (_ isActive: Bool) -> Void) {
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
            guard let snap = snapshot.value as? [String: AnyObject] else { return }
            User.name = snap["name"] as? String
            User.email = snap["email"] as? String
            User.profileImage = snap["profileImage"] as? String
            User.id = uid
            User.isMapLocationEnabled = snap["isMapLocationEnabled"] as? Bool
            UserActivity.observe(isOnline: true)
//            if User.isMapLocationEnabled ?? false {
//                ChatKit.map.showsUserLocation = true
//                ChatKit.startUpdatingUserLocation()
//            }
            if User.id == nil || User.profileImage == nil || User.name == nil{
                do{
                    try Auth.auth().signOut()
                    return completion(false)
                }catch{
                    
                }
            }
            return completion(true)
        }
    }
    
    
    func checkForExistingEmail(_ email: String, completion: @escaping (_ errorMessage: String?) -> Void){
        networkingLoadingIndicator.startLoadingAnimation()
        Auth.auth().fetchSignInMethods(forEmail: email) { methods, error in
            self.networkingLoadingIndicator.endLoadingAnimation()
            if methods == nil {
                return completion(nil)
            }else{
                return completion("This email is already in use.")
            }
        }
    }
    
    
    // MARK: SignUp User Method
    
    func registerUser(_ name: String, _ email: String, _ password: String, _ profileImage: UIImage?, completion: @escaping (_ error: String?) -> Void){
        
        networkingLoadingIndicator.startLoadingAnimation()
        
        Auth.auth().createUser(withEmail: email, password: password) { dataResult, error in
            
            if let error = error { return completion(error.localizedDescription) }
            
            guard let uid = dataResult?.user.uid else { return completion("Error occured, try again!") }
            
            let imageToSend = profileImage ?? UIImage(named: "DefaultUserImage")
            
            self.uploadProfileImageToStorage(imageToSend!) { (url, error) in
                if let error = error { return completion(error.localizedDescription) }
                guard let url = url else { return }
                let values: [String: Any] = ["name": name, "email": email, "profileImage": url.absoluteString, "isMapLocationEnabled": false]
                self.registerUserHandler(uid, values) { (error) in
                    if let error = error { return completion(error.localizedDescription) }
                }
            }
        }
    }
    
    
    private func registerUserHandler(_ uid: String, _ values: [String:Any], completion: @escaping (_ error: Error?) -> Void) {
        let usersRef = Database.database().reference().child("users").child(uid)
        usersRef.updateChildValues(values) { (error, dataRef) in
            if let error = error { return completion(error) }
            self.nextController()
        }
    }
    
    
    // MARK: Upload Image Method
    private func uploadProfileImageToStorage(_ image: UIImage, completion: @escaping (_ imageUrl: URL?, _ error: Error?) -> Void){
        let uniqueName = NSUUID().uuidString
        let storagRef = Storage.storage().reference().child("ProfileImages").child("\(uniqueName).jpg")
        if let uploadData = image.jpegData(compressionQuality: 0.1) {
            storagRef.putData(uploadData, metadata: nil) { (metaData, error) in
                if let error = error { return completion(nil, error) }
                storagRef.downloadURL { (url, error) in
                    if let error = error { return completion(nil, error) }
                    if let url = url { return completion(url, nil) }
                }
            }
        }
    }
}
