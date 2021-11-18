//
//  CamVC.swift
//  SnapChat
//
//  Created by sara saud on 11/14/21.
//
import AVFoundation
import UIKit
class CamVC : UIViewController {
    
    
  // Capture Session
  var session : AVCaptureSession?
  // Photo Output
  let output = AVCapturePhotoOutput()
  // Video Preview
  let previewLayer = AVCaptureVideoPreviewLayer()
  // Shutter button
  private let shutterButton : UIButton = {
    let button = UIButton(frame: CGRect(x: 0, y: 0, width: 90, height: 90 ))
      button.layer.cornerRadius = 45
      button.layer.borderWidth = 7
      button.layer.borderColor = UIColor.white.cgColor
    return button
  }()
  override func viewDidLoad() {
  super.viewDidLoad()
    checkCameraPermissions()
    view.backgroundColor = .black
    view.layer.addSublayer(previewLayer)
    view.addSubview(shutterButton)
    shutterButton.addTarget(self, action: #selector(didTapTakePhoto), for: .touchUpInside)
      
      let swipelift = UISwipeGestureRecognizer(
            target: self,
            action: #selector(openTikTok))
          swipelift.direction = .left
          view.addGestureRecognizer(swipelift)
          view.isUserInteractionEnabled = true
        
  }
    @objc private func openTikTok() {
        let TikTokVC = TikTok()
        TikTokVC.modalPresentationStyle = .fullScreen
        self.present(TikTokVC, animated: true, completion: nil)
    }
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    previewLayer.frame = view.bounds
    shutterButton.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height - 200)
  }
  private func checkCameraPermissions() {
    switch AVCaptureDevice.authorizationStatus(for: .video){
  case .notDetermined:
    //Request
      AVCaptureDevice.requestAccess(for: .video){[weak self]
        granted in
        guard granted else {
          return
        }
        DispatchQueue.main.async {
          self?.setUpCamera()
        }
      }
  case .restricted:
    break
  case .denied:
    break
  case .authorized:
    setUpCamera()
  @unknown default:
    break
    } }
  private func setUpCamera() {
    let session = AVCaptureSession()
    if let device = AVCaptureDevice.default(for: .video) {
      do {
        let input = try AVCaptureDeviceInput(device: device)
        if session.canAddInput(input){
          session.addInput(input)
        }
        if session.canAddOutput(output) {
          session.addOutput(output)
        }
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.session = session
        session.stopRunning()
        self.session = session
      }
      catch {
        print(error)
      }
    }
  }
  @objc private func didTapTakePhoto() {
    output.capturePhoto(with: AVCapturePhotoSettings() , delegate: self)
  }
}
extension CamVC: AVCapturePhotoCaptureDelegate {
  func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
    guard let data = photo.fileDataRepresentation() else {
      return
    }
    let image = UIImage(data: data)
    session?.stopRunning()
    let imageView = UIImageView(image: image)
    imageView.contentMode = .scaleToFill
    imageView.frame = view.bounds
    view.addSubview(imageView)
  }
}
