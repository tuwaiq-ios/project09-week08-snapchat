//
//  CameraVC.swift
//  TuwaiqChat
//
//  Created by Maram Al shahrani on 11/04/1443 AH.
//

import UIKit
import FirebaseAuth
import AVFoundation
import Photos
import FirebaseFirestore
import FirebaseStorage


class CameraVC: UIViewController {
    
    private var session: AVCaptureSession?
    private let photoOut = AVCapturePhotoOutput()
    private let videoLayer = AVCaptureVideoPreviewLayer()
    private var isFlashOn = false
    private let db = Firestore.firestore()
    private let storage = Storage.storage()
    
    private let recordButton: UIButton  = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "camera")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        btn.layer.cornerRadius = 30
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
        btn.setupButton(using: "bolt.slash")
        return btn
    }()
    
    let userProcessedImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        view.layer.addSublayer(videoLayer)
        
        navigationItem.title = "TuwaiqChat"
        
        setupRecordButton()
        
        hasUserGavePermissionForCamera()
        setupCameraButtons()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !isUserIsSignedIn() {
            showWelcomeScreen()
        }
        readImageFromFirestore()
        
        
    }
    
    
    
    private func readImageFromFirestore(){
        guard let currentUser = Auth.auth().currentUser else {return}
        
        db.collection("Profiles").whereField("email", isEqualTo: String(currentUser.email!))
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
                                        // Uh-oh, an error occurred!
                                        print("ERROR GETTING DATA \(error.localizedDescription)")
                                    } else {
                                        // Data for "images/island.jpg" is returned
                                        
                                        //                                      DispatchQueue.main.async {
                                        //                                          self.profileImage.image = UIImage(data: data!)
                                        //                                      }
                                        //
                                    }
                                }
                                
                            } else {
                                
                                print("error converting data")
                                
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
        stackView.layer.borderColor = UIColor.red.cgColor
        
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
        let vc = UINavigationController(rootViewController: TabBarVC())
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
            //user is probably aged below 18 and can't give permissions
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
        
        
        if sessionForAV.canAddOutput( photoOut) {
            sessionForAV.addOutput( photoOut)
        }
        
        
        videoLayer.videoGravity = .resizeAspectFill
        
        videoLayer.session = sessionForAV
        videoLayer.frame = CGRect(x: 0, y:0, width: view.frame.width , height: view.frame.height)
        
        
        sessionForAV.startRunning()
        self.session = sessionForAV
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
        stackView.layer.borderColor = UIColor.green.cgColor
        
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
        photoOut.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }
    
    @objc private func flashButtonTapped() {
        print(isFlashOn)
        isFlashOn = !isFlashOn
        toggleFlash(on: isFlashOn)
        flashButton.setupButton(using: isFlashOn ? "bolt" : "bolt.slash")
        
    }
    
    @objc private func profileBarImageTapped() {
        navigationController?.pushViewController(UserProfileVC(), animated: true)
    }
}

extension CameraVC: AVCapturePhotoCaptureDelegate {
    func PhotoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
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
        backgroundColor = .white
        setTitle(title, for: .normal)
        setTitleColor(.black, for: .normal)
        layer.cornerRadius = 20
        clipsToBounds = true
    }
    
    open func setupButton(using image: String) {
        setImage(UIImage(systemName: image)?.withTintColor(.red, renderingMode: .alwaysOriginal), for: .normal)
        backgroundColor = .clear
        layer.borderColor = UIColor.blue.cgColor
    }
}
