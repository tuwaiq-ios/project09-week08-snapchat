//
//  RegisterVC.swift
//  snapchatt
//
//  Created by sally asiri on 08/04/1443 AH.
//

import UIKit

class RegisterVC: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    lazy var profileImage: UIImageView = {
       let view = UIImageView()
       view.translatesAutoresizingMaskIntoConstraints = false
       view.backgroundColor = .systemGreen
       view.layer.cornerRadius = 25
       view.isUserInteractionEnabled = true

       return view
   }()
    lazy var imagePicker : UIImagePickerController = {
       let imagePicker = UIImagePickerController()
       imagePicker.delegate = self
       imagePicker.sourceType = .photoLibrary
       imagePicker.allowsEditing = true
       //let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
      //  profileImage.addGestureRecognizer(tapRecognizer)
       return imagePicker
   }()
    
    lazy var firstName: UITextField = {
      let firstName = UITextField()
        firstName.translatesAutoresizingMaskIntoConstraints = false
        firstName.layer.cornerRadius = 12
        firstName.layer.borderWidth = 1
        firstName.layer.borderColor = UIColor.lightGray.cgColor
        firstName.placeholder = " First Name..."
        firstName.backgroundColor = .secondarySystemBackground
      return firstName
  }()
    
    lazy var lastName: UITextField = {
      let lastName = UITextField()
        lastName.translatesAutoresizingMaskIntoConstraints = false
        lastName.layer.cornerRadius = 12
        lastName.layer.borderWidth = 1
        lastName.layer.borderColor = UIColor.lightGray.cgColor
        lastName.placeholder = "  Last Name..."
        lastName.backgroundColor = .secondarySystemBackground
      return lastName
  }()
      lazy var userEmail: UITextField = {
        let userEmail = UITextField()
          userEmail.translatesAutoresizingMaskIntoConstraints = false
          userEmail.layer.cornerRadius = 12
          userEmail.layer.borderWidth = 1
          userEmail.layer.borderColor = UIColor.lightGray.cgColor
          userEmail.placeholder = "  Email Address..."
          userEmail.backgroundColor = .secondarySystemBackground
        return userEmail
    }()

    private let userPassword: UITextField = {
        let userPassword = UITextField()
        userPassword.translatesAutoresizingMaskIntoConstraints = false
        userPassword.layer.cornerRadius = 12
        userPassword.layer.borderWidth = 1
        userPassword.layer.borderColor = UIColor.lightGray.cgColor
        userPassword.placeholder = "  Password..."
        userPassword.backgroundColor = .secondarySystemBackground
        return userPassword
    }()

    private let registerButton: UIButton = {
        let registerButton = UIButton()
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.setTitle("Register", for: .normal)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.backgroundColor = .systemCyan
        registerButton.layer.cornerRadius = 12
        registerButton.layer.masksToBounds = true
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        registerButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return registerButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        title = "Log In"

        //Constraint firstName
        view.addSubview(profileImage)
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: view.topAnchor, constant:90),
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImage.heightAnchor.constraint(equalToConstant: 170),
            profileImage.widthAnchor.constraint(equalTo: profileImage.heightAnchor,multiplier: 100/100)
        ])
        view.addSubview(firstName)
        NSLayoutConstraint.activate([
            firstName.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            firstName.topAnchor.constraint(equalTo: profileImage.topAnchor, constant: 200),
            firstName.widthAnchor.constraint(equalToConstant: 350),
            firstName.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        //Constraint lastName
        view.addSubview(lastName)
        NSLayoutConstraint.activate([
            lastName.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            lastName.topAnchor.constraint(equalTo: firstName.bottomAnchor, constant: 16),
            lastName.widthAnchor.constraint(equalToConstant: 350),
            lastName.heightAnchor.constraint(equalToConstant: 40),
        ])
        //Constraint userEmail
        view.addSubview(userEmail)
        NSLayoutConstraint.activate([
            userEmail.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            userEmail.topAnchor.constraint(equalTo: lastName.bottomAnchor, constant: 16),
            userEmail.widthAnchor.constraint(equalToConstant: 350),
            userEmail.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        //Constraint userPassword
        view.addSubview(userPassword)
        NSLayoutConstraint.activate([
            userPassword.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            userPassword.topAnchor.constraint(equalTo: userEmail.bottomAnchor, constant: 16),
            userPassword.widthAnchor.constraint(equalToConstant: 350),
            userPassword.heightAnchor.constraint(equalToConstant: 40),
        ])
        //Constraint loginButton
        view.addSubview(registerButton)
        NSLayoutConstraint.activate([
            registerButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            registerButton.topAnchor.constraint(equalTo: userPassword.bottomAnchor, constant: 16),
            registerButton.widthAnchor.constraint(equalToConstant: 300),
            registerButton.heightAnchor.constraint(equalToConstant: 40),
        ])
        
  
    }
    
    @objc private func registerButtonTapped() {
    present(RegisterVC(), animated: true, completion: nil)
        }

  @objc func imageTapped() {
    print("Image tapped")
      present(imagePicker, animated: true)
  }
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    let image = info[.editedImage] ?? info [.originalImage] as? UIImage
      profileImage.image = image as? UIImage
    dismiss(animated: true)
  }
}

