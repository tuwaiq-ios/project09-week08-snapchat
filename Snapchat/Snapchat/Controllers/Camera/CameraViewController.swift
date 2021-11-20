//
//  MapsNetworking.swift
//  Snapchat
//
//  Created by Jawaher🌻 on 10/04/1443 AH.
//

import AVFoundation
import UIKit
import CoreServices
import Lottie
import FirebaseAuth

class CameraViewController : UIViewController,UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    let Image: UIImageView = {
        let pI = UIImageView()
        pI.clipsToBounds = true
        pI.contentMode = .scaleAspectFill
        pI.layer.masksToBounds = true
        return pI
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.backgroundColor = .white
        Image.tintColor = .systemGray3
        Image.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
            Image.leftAnchor.constraint(equalTo: view.leftAnchor),
            Image.rightAnchor.constraint(equalTo: view.rightAnchor),
            Image.topAnchor.constraint(equalTo: view.topAnchor),
            Image.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -77)
               ])
        
    }
    
    
    @objc private func presentPhotoInputActionsheet() {
            let actionSheet = UIAlertController(title: "Attach Photo 📷 ",
                                                message: "Where would you like to attach a photo from",
                                                preferredStyle: .actionSheet)
            actionSheet.addAction(UIAlertAction(title: "Camera 📷", style: .default, handler: { [weak self] _ in

                let picker = UIImagePickerController()
                picker.sourceType = .camera
                picker.delegate = self
                picker.allowsEditing = true
                self?.present(picker, animated: true)
     
            }))
            actionSheet.addAction(UIAlertAction(title: "Photo Library 🌄", style: .default, handler: { [weak self] _ in

                let picker = UIImagePickerController()
                picker.sourceType = .photoLibrary
                picker.delegate = self
                picker.allowsEditing = true
                self?.present(picker, animated: true)

            }))
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

            present(actionSheet, animated: true)
        setupImagePicker()
        }
    
    
    
    func setUpImage() {
        
        Image.tintColor  = .systemBlue
        Image.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(presentPhotoInputActionsheet))
        
        Image.addGestureRecognizer(tapRecognizer)
        
        view.addSubview(Image)
    }
    func setupImagePicker() {
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
       
    }
    
            
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      picker.dismiss(animated: true, completion: nil)
      guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
        return
      }
      self.Image.image = selectedImage
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
      picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func imageTapped() {
        print("Image tapped")
        setupImagePicker()
    }
    
    override func viewDidLoad() {
      super.viewDidLoad()
        setUpImage()
        view.backgroundColor = .systemGray3
      }

}
