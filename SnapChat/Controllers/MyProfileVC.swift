//
//  ProfileVC.swift
//  SnapChat
//
//  Created by Amal on 04/04/1443 AH.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class MyProfileVC: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    let myColor = UIColor(named: "myBackgroundColor")
    var users: Array<User> = []

    //image picker
    lazy var profileImage: UIImageView = {
       let image = UIImageView()
       image.translatesAutoresizingMaskIntoConstraints = false
       image.backgroundColor = .yellow
       image.layer.cornerRadius = 25
        image.isUserInteractionEnabled = true
                              
       return image
   }()
    lazy var imagePicker : UIImagePickerController = {
       let imagePicker = UIImagePickerController()
       imagePicker.delegate = self
       imagePicker.sourceType = .photoLibrary
       imagePicker.allowsEditing = true
       
       return imagePicker
   }()
    
    //user name
    lazy var nameLabel: UITextField = {
       let label = UITextField()
       label.translatesAutoresizingMaskIntoConstraints = false
       label.text = ""
        label.placeholder = (NSLocalizedString("namep", comment: ""))
//        label.borderStyle = .line
       return label
   }()

    // user status
    lazy var userStatusLabel: UITextField = {
        let label = UITextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.placeholder = (NSLocalizedString("stp", comment: ""))
//        label.borderStyle = .line
        return label
    }()
    
    //save the name and image and statuse
    lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("savep", comment: ""), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
        button.layer.masksToBounds = true
        button.backgroundColor = .systemGray6
        return button
    }()
    
    lazy var shareButton: UIButton = {
        let button = UIButton (type: .system)
        button.setTitle(NSLocalizedString("sharep", comment: ""), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .quaternaryLabel
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(sharePressed), for: .touchUpInside)
        button.layer.masksToBounds = true
        button.backgroundColor = .systemGray6

        return button
    }()
    //sing out from snap chat
    lazy var singOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("signp", comment: ""), for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(singOutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad () {
        super.viewDidLoad()

        // Gesture to image
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
         profileImage.addGestureRecognizer(tapRecognizer)

        view.addSubview(profileImage)
        NSLayoutConstraint.activate([
            profileImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -100),
            profileImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            profileImage.widthAnchor.constraint(equalToConstant: 200),
            profileImage.heightAnchor.constraint(equalToConstant: 200),
        ])
        view.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -100),
            nameLabel.topAnchor.constraint(equalTo: profileImage.topAnchor, constant: 250),
            nameLabel.widthAnchor.constraint(equalToConstant: 200),
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        //Constraint lastName
        view.addSubview(userStatusLabel)
        NSLayoutConstraint.activate([
            userStatusLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -100),
            userStatusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            userStatusLabel.widthAnchor.constraint(equalToConstant: 200),
            userStatusLabel.heightAnchor.constraint(equalToConstant: 40),
        ])
        //Constraint userEmail
        view.addSubview(saveButton)
        NSLayoutConstraint.activate([
            saveButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -70),
            saveButton.topAnchor.constraint(equalTo: userStatusLabel.bottomAnchor, constant: 16),
            saveButton.widthAnchor.constraint(equalToConstant: 250),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        //Constraint userPassword
        view.addSubview(shareButton)
        NSLayoutConstraint.activate([
            shareButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -70),
            shareButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 16),
            shareButton.widthAnchor.constraint(equalToConstant: 250),
            shareButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        //Constraint loginButton
        view.addSubview((singOutButton))
        NSLayoutConstraint.activate([
            (singOutButton).rightAnchor.constraint(equalTo: view.rightAnchor, constant: -70),
            (singOutButton).topAnchor.constraint(equalTo: (shareButton).bottomAnchor, constant: 30),
            (singOutButton).widthAnchor.constraint(equalToConstant: 250),
            (singOutButton).heightAnchor.constraint(equalToConstant: 50),
        ])
        
    
        guard let currentUserID = Auth.auth().currentUser?.uid else {return}
        RegisterService.shared.listenToUsers { ubdateUser in
            self.users = ubdateUser
        }
    }
    
    //sing out from snap chat
    @objc private func singOutButtonTapped() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: \(signOutError.localizedDescription)")
        }
        present(LogInVC(), animated: true, completion: nil)
    }
    
    //update name , image , status in fire store
    @objc private func updateButtonTapped() {
        
        guard let currentUserID = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().document("users/\(currentUserID)").updateData([
            "name" : nameLabel.text,
            "id" : currentUserID,
            "status" :userStatusLabel.text,
            "image":"\(profileImage.image)"
        ])
        
        let alert1 = UIAlertController(
            title: ("Saved"),message: "Saved update data",preferredStyle: .alert)
        alert1.addAction(UIAlertAction(title: "OK",style: .default,handler: { action in
            print("OK")
        }
                                      )
        )
        present(alert1, animated: true, completion: nil)
    }
    
    //image picker
    @objc func imageTapped() {
        print("Image tapped")
        present(imagePicker, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] ?? info [.originalImage] as? UIImage
        profileImage.image = image as? UIImage
        dismiss(animated: true)
    }
    
    //share
    @objc func sharePressed (_ sender: Any) {
        let activityVC = UIActivityViewController(activityItems: [self.nameLabel.text], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
}
