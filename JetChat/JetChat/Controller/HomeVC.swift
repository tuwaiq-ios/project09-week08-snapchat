//
//  HomeVC.swift
//  JetChat
//
//  Created by Sana Alshahrani on 09/04/1443 AH.
//

import UIKit
import FirebaseAuth
import AVFoundation
import Photos
import FirebaseFirestore
import FirebaseStorage

class HomeVC: UIViewController {
    
    private var sessionForAV: AVCaptureSession?
    private let photoOutput = AVCapturePhotoOutput()
    private let videoPreviewLayer = AVCaptureVideoPreviewLayer()
    private var isFlashOn = false
    private let db = Firestore.firestore()
    private let storage = Storage.storage()
    
    private let recordButton: UIButton  = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "camera.on.rectangle")?.withTintColor(.red, renderingMode: .alwaysOriginal), for: .normal)
        btn.layer.cornerRadius = 15
        btn.backgroundColor = .clear
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.borderWidth = 2
        return btn
    }()
    
    let previewContainer: UIView = {
        let pC = UIView()
        return pC
    }()
    let cancelPhotoButton: UIButton = {
        let btn = UIButton(type: .system)

        btn.setupButton(using: "xmark")
        
        return btn
    }()
    let savePhotoButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setupButton(using: "square.and.arrow.down")
        return btn
    }()
    
    let flashButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setupButton(using: "bolt.slash.circle")
        return btn
    }()
    
    let userProcessedImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let profileImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 60/2
        img.layer.borderColor = UIColor.white.cgColor
        img.layer.borderWidth = 2
        img.clipsToBounds = true
        return img
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        view.layer.addSublayer(videoPreviewLayer)
       
        navigationItem.title = "SnapHome".localized()
        
        setupRecordButton()
        hasUserGavePermissionForCamera()
        setupCameraButtons()
        setupProfileImage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !isUserIsSignedIn() {
        showWelcomeScreen()
        }
        readImageFromFirestore()
    }
    
    private func setupProfileImage() {
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profileBarImageTapped)))
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(profileImage)
        
        profileImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        profileImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }

  
    private func readImageFromFirestore(){
        guard let currentUser = Auth.auth().currentUser else {return}
        
        db.collection("users").whereField("email", isEqualTo: String(currentUser.email!))
            .addSnapshotListener { (querySnapshot, error) in
                if let e = error {
                    print("There was an issue retrieving data from Firestore. \(e)")
                } else {
                    
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            
                            if let imageURL = data["userImageURL"] as? String
                            {
                                
                                let httpsReference = self.storage.reference(forURL: imageURL)

                           
                                httpsReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
                                  if let error = error {
                                    
                                      print("ERROR GETTING DATA \(error.localizedDescription)")
                                  } else {
                                    
                                      
                                      DispatchQueue.main.async {
                                          self.profileImage.image = UIImage(data: data!)
                                      }
                                      
                                  }
                                }
                                
                            } else {
                               
                                print("error converting data")
                                DispatchQueue.main.async {
                                    self.profileImage.image = UIImage(systemName: "person.crop.circle.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
                                }
                            }
                        }
                    }
                }
            }
    }
    
    private func isUserIsSignedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    private func setupCameraButtons() {
        
        flashButton.addTarget(self, action: #selector(flashButtonTapped), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews:  [flashButton])
        
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .clear
        stackView.layer.cornerRadius = 10
        stackView.clipsToBounds = true
        stackView.layer.borderWidth = 2
        stackView.layer.borderColor = UIColor.white.cgColor
        
        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
    }
    
    private func setupRecordButton(){
        
        recordButton.addTarget(self, action: #selector(recordButtonTapped), for: .touchUpInside)
        
        recordButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(recordButton)
        recordButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        recordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        recordButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        recordButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    private func showWelcomeScreen() {
        let vc = UINavigationController(rootViewController: Login())
        vc.modalTransitionStyle = .flipHorizontal
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    private func hasUserGavePermissionForCamera() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setupCapturingProcess()
        case .denied:
            let alert = UIAlertController(title: "Oops", message: "Please allow the app to access your camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(alert, animated: true)
            
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { authorized in
                if authorized {
                    DispatchQueue.main.async {
                        self.setupCapturingProcess()
                    }
                }
            }
            
        case .restricted:
            
            let alert = UIAlertController(title: "Oops", message: "To allow this app to function probably, please consult your parents to give permission.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(alert, animated: true)
            
        default:
            break
        }
    }
    
    private func setupCapturingProcess() {
        let sessionForAV = AVCaptureSession()
        guard let userDevice = AVCaptureDevice.default(for: .video) else {return}
        
        do {
            let inputDevice = try AVCaptureDeviceInput(device: userDevice)
            
            if sessionForAV.canAddInput(inputDevice) {
                sessionForAV.addInput(inputDevice)
            }
            
        }catch let err {print("error getting input from device \(err.localizedDescription)")}
        
        if sessionForAV.canAddOutput(photoOutput) {
            sessionForAV.addOutput(photoOutput)
        }
        
        videoPreviewLayer.videoGravity = .resizeAspectFill
        videoPreviewLayer.session = sessionForAV
        videoPreviewLayer.frame = CGRect(x: 0, y:0, width: view.frame.width , height: view.frame.height)
  
      
        sessionForAV.startRunning()
        self.sessionForAV = sessionForAV
    }
    
    private func toggleFlash(on: Bool ) {
        guard let device = AVCaptureDevice.default(for: .video), device.hasTorch else { return }
        
        do {
            try device.lockForConfiguration()
            
            device.torchMode = on ? .on : .off
            
            if on {
                try device.setTorchModeOn(level: AVCaptureDevice.maxAvailableTorchLevel)
            }
            
            device.unlockForConfiguration()
        } catch {
            print("Error: \(error)")
        }
    }
    
    private func setupPreviewButtons() {
        
        savePhotoButton.addTarget(self, action: #selector(savePreviewPhotoToLibrary), for: .touchUpInside)
        cancelPhotoButton.addTarget(self, action: #selector(cancelPreviewPhoto), for: .touchUpInside)
        
        previewContainer.addSubview(userProcessedImage)
        
        let stackView = UIStackView(arrangedSubviews:  [cancelPhotoButton, savePhotoButton])
        
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .clear
        stackView.layer.cornerRadius = 10
        stackView.clipsToBounds = true
        stackView.layer.borderWidth = 2
        stackView.layer.borderColor = UIColor.blue.cgColor
        
        previewContainer.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: previewContainer.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: previewContainer.trailingAnchor, constant: -10).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: 40).isActive = true
      
        stackView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
    }
    @objc private func cancelPreviewPhoto() {
        DispatchQueue.main.async {
            self.userProcessedImage.removeFromSuperview()
            self.previewContainer.removeFromSuperview()
        }
    }
    @objc private func savePreviewPhotoToLibrary() {
        guard let previewPhoto = userProcessedImage.image else {return}
        
        PHPhotoLibrary.requestAuthorization(for: .addOnly) { authorizationStatus in
            
            if authorizationStatus == .authorized {
                do {
                    try PHPhotoLibrary.shared().performChangesAndWait {
                        PHAssetChangeRequest.creationRequestForAsset(from: previewPhoto)
                        print("User saved photo to his library")
                        
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "Awesome!", message: "you photo has been saved", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
                                self.cancelPreviewPhoto()
                            }))
                            
                            self.present(alert, animated: true)
                        }
                        
                    }
                }catch let err {
                    print("we couldn't save the photo with error: \(err)")
                }
            }else{
                let alert = UIAlertController(title: "Oops!", message: "Please check if you allowed the app to access your library", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
                self.present(alert, animated: true)
            }
            
        }
    }
    @objc private func recordButtonTapped() {
        photoOutput.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }
    
    @objc private func flashButtonTapped() {
        print(isFlashOn)
        isFlashOn = !isFlashOn
        toggleFlash(on: isFlashOn)
        flashButton.setupButton(using: isFlashOn ? "bolt" : "bolt.slash")
        
    }
    
    @objc private func profileBarImageTapped() {
        navigationController?.pushViewController(ProfileVC(), animated: true)
    }
}

extension HomeVC: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard let photo = photo.fileDataRepresentation() else {return}
        
        let processedImage = UIImage(data: photo)
        
        previewContainer.frame   =  view.frame
        userProcessedImage.image =  processedImage
        userProcessedImage.frame =  previewContainer.frame
        setupPreviewButtons()
        
        view.addSubview(previewContainer)
    }
}
extension UIButton {
    open func setupButton(with title: String) {
        backgroundColor = .blue
        setTitle(title, for: .normal)
        setTitleColor(.black, for: .normal)
        layer.cornerRadius = 20
        clipsToBounds = true
    }
    
    open func setupButton(using image: String) {
        setImage(UIImage(systemName: image)?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        backgroundColor = .clear
        layer.borderColor = UIColor.white.cgColor
    }
}
