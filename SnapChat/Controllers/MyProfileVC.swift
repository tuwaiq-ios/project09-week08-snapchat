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
    
    var users: Array<User> = []
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
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
        label.borderStyle = .line
       return label
   }()
    lazy var usernameStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 16
        return view
    }()
    
    // user status
    lazy var userStatusLabel: UITextField = {
        let label = UITextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.borderStyle = .line
        return label
    }()
    
    //save the name and image and statuse
    lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline, compatibleWith: .init(legibilityWeight: .bold))
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 250).isActive = true
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
        button.layer.masksToBounds = true
        button.backgroundColor = .black
        return button
    }()
    
    lazy var shareButton: UIButton = {
        let button = UIButton (type: .system)
        button.setTitle("ShareURL", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline, compatibleWith: .init(legibilityWeight: .bold))
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 250).isActive = true
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(sharePressed), for: .touchUpInside)
        button.layer.masksToBounds = true
        button.backgroundColor = .black

        return button
    }()
    //sing out from snap chat
    lazy var singOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sing out", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont (forTextStyle: .headline, compatibleWith: .init(legibilityWeight: .bold))
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 250).isActive = true
        button.addTarget(self, action: #selector(singOutButtonTapped), for: .touchUpInside)
        return button
    }()
    // stack view to sing out and share URL
    lazy var verticalStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .equalSpacing
        return view
    }()
    
    override func viewDidLoad () {
        super.viewDidLoad()

        // Gesture to image
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
         profileImage.addGestureRecognizer(tapRecognizer)
        
        view.backgroundColor = .white
   
        view.addSubview(containerView)
        containerView.addSubview (verticalStackView)
        verticalStackView.addArrangedSubview(profileImage)
        verticalStackView.addArrangedSubview (nameLabel)
        verticalStackView.addArrangedSubview(usernameStackView)
        usernameStackView.addArrangedSubview (userStatusLabel)
        verticalStackView.addArrangedSubview(saveButton)
        verticalStackView.addArrangedSubview(shareButton)
        verticalStackView.addArrangedSubview(singOutButton)
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 500),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.leadingAnchor.constraint (equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 6),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: containerView.trailingAnchor, multiplier: 6),
            verticalStackView.topAnchor.constraint(equalToSystemSpacingBelow: containerView.topAnchor, multiplier: 2),
            verticalStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: containerView.leadingAnchor, multiplier: 6),
            containerView.trailingAnchor.constraint(equalToSystemSpacingAfter: verticalStackView.trailingAnchor, multiplier: 6),
            containerView.bottomAnchor.constraint (equalToSystemSpacingBelow: verticalStackView.bottomAnchor, multiplier: 3),
            profileImage.heightAnchor.constraint (equalToConstant: 200),
            profileImage.widthAnchor.constraint(equalToConstant: 200),
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
