//
//  SelectProfileImageViewController.swift
//  Snapchat
//
//  Created by Eth Os on 08/04/1443 AH.
//

import UIKit


class SelectProfileImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var name: String!
    var email: String!
    var password: String!
    
    var userServices: UserServices!
    var selectedImage: UIImage!
    var profileImage = UIImageView(image: UIImage(named: "DefaultUserImage"))
    var continueButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientView()
        setupRegistrationInfoView()
        setupBackButton()
        setupContinueButton()
    }
    
    
    private func setupGradientView() {
        let _ = GradientView(self)
    }
    
    private func setupRegistrationInfoView(){
        let _ = RegistrationInfoView(frame: view.frame, self, profileImage: profileImage)
    }
    
    private func setupContinueButton() {
        view.addSubview(continueButton)
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.setTitle("CONTINUE", for: .normal)
        continueButton.tintColor = UIColor(red: 100/255, green: 90/255, blue: 255/255, alpha: 1)
        continueButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        continueButton.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)
        let constraints = [
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupBackButton() {
        let backButton = AuthBackButton(self)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
    
    @objc private func backButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: Change Image Method
    
    @objc func changeImagePressed() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { (alertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            }
        }))
        alert.addAction(UIAlertAction(title: "Open Photo Library", style: .default, handler: { (alertAction) in
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }))
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        cancelAction.setValue(UIColor.systemRed, forKey: "titleTextColor")
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImage = editedImage
        }else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImage = originalImage
        }
        if let userImage = selectedImage {
            profileImage.image = userImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Continue Button Pressed Method
    
    @objc private func continueButtonPressed(){
        userServices = UserServices(self)
        userServices.registerUser(name, email, password, profileImage.image) { (error) in
            self.userServices.networkingLoadingIndicator.endLoadingAnimation()
            self.showAlert(title: "Error", message: error)
        }
    }
    
    
}
