//
//  ProfileViewController.swift
//  Snapchat
//
//  Created by Eth Os on 08/04/1443 AH.
//

import UIKit
import FirebaseAuth
import FirebaseStorage

class ProfileViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {

   
    
    var profileImage = UIImageView()
    let nameLabel = UILabel()
    let emailLabel = UILabel()
    let darkBackground = UIView()
    let logoutButton = UIButton(type: .system)
    var uploadButton = UIButton(type: .system)
    let storeg = Storage.storage().reference()
    let isOnlineView = UIView()
    var profileNetworking: ProfileNetworking!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Profile"
        // Do any additional setup after loading the view.
        profileNetworking = ProfileNetworking(self)
        setupLeftNavButton()
        setupImageProfile()
        setupGradientView()
        setupUploadButton()
        setupInfoLabels()
        setupIsOnlineImage()
        
    }
    
    
    private func setupLeftNavButton(){
        logoutButton.setTitle("Sign out", for: .normal)
        logoutButton.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 18)
        logoutButton.setTitleColor(.systemRed, for: .normal)
        logoutButton.addTarget(self, action: #selector(setupLogoutView), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: logoutButton)
    }
    
    func setupInfoLabels() {
        
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = User.name.uppercased()
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        view.addSubview(emailLabel)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.text = User.email.uppercased()
        emailLabel.font = UIFont.boldSystemFont(ofSize: 12)
        emailLabel.textColor = .lightGray
        let constraints = [
            nameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 8),
            nameLabel.centerXAnchor.constraint(equalTo: profileImage.centerXAnchor),
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            emailLabel.centerXAnchor.constraint(equalTo: profileImage.centerXAnchor)
        ]
    
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc private func setupLogoutView() {
        let alert = UIAlertController(title: "Sign Out", message: "Are you sure you want to sign out?", preferredStyle: .alert)
        let exitAction = UIAlertAction(title: "Exit", style: .destructive) { (true) in
            self.logoutButtonPressed()
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(exitAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func setupGradientView() {
        let _ = GradientView(self)
        setupImageProfile()
        navigationItem.title = "Profile"
    }
    
    
    private func setupImageProfile(){
        view.addSubview(profileImage)
        profileImage.loadImage(url: User.profileImage)
        profileImage.contentMode = .scaleAspectFill
        profileImage.layer.cornerRadius = 50
        profileImage.layer.shadowColor = UIColor.lightGray.cgColor
        profileImage.layer.shadowOffset = CGSize(width: 0, height: 3.5)
        profileImage.layer.shadowRadius = 10
        profileImage.layer.shadowOpacity = 0.2
        profileImage.layer.masksToBounds = true
        profileImage.layer.borderWidth = 2.5
        profileImage.layer.borderColor = UIColor.white.cgColor
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            profileImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImage.heightAnchor.constraint(equalToConstant: 100),
            profileImage.widthAnchor.constraint(equalToConstant: 100)
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
    private func setupIsOnlineImage(){
        profileImage.addSubview(isOnlineView)
        isOnlineView.layer.cornerRadius = 10
        isOnlineView.layer.borderColor = UIColor.white.cgColor
        isOnlineView.layer.borderWidth = 2.5
        isOnlineView.layer.masksToBounds = true
        isOnlineView.backgroundColor = UIColor(displayP3Red: 90/255, green: 180/255, blue: 55/255, alpha: 1)
        isOnlineView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            isOnlineView.leadingAnchor.constraint(equalTo: profileImage.leadingAnchor, constant: 10),
            isOnlineView.widthAnchor.constraint(equalToConstant: 20),
            isOnlineView.heightAnchor.constraint(equalToConstant: 20),
            isOnlineView.bottomAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: -11)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupUploadButton() {
        view.addSubview(uploadButton)
        uploadButton.translatesAutoresizingMaskIntoConstraints = false
        uploadButton.setTitle("CHANG PROFILE IMAGE", for: .normal)
        uploadButton.tintColor = ThemeColors.mainColor
        uploadButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        uploadButton.addTarget(self, action: #selector(changeProfileImage), for: .touchUpInside)
        let constraints = [
            uploadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            uploadButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc private func logoutButtonPressed(){
        
        UserActivity.observe(isOnline: false)
            do{
                try Auth.auth().signOut()
                let vc = LoginViewController()
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
                
            }catch{
                print("Faild to log out")
            }
    
    }
    
    @objc func changeProfileImage() {
        print("pressed !!! ")
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
        guard let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        profileNetworking.uploadImageToStorage(originalImage) { (url, error) in
            guard error == nil , let url = url else { return }
            self.profileNetworking.updateCurrentUserInfo(url)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
