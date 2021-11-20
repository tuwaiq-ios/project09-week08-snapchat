//
//  UserInfoTab.swift
//  Snapchat
//
//  Created by Jawaher🌻 on 10/04/1443 AH.
//


import UIKit
import Mapbox

class UserInfoTab: UIView{
    
  
    
    let mapsVC = MapsVC()
    var pin: AnnotationPin!
    let profileImage = UIImageView()
    let nameLabel = UILabel()
    let lastSeenLabel = UILabel()
    let actionButton = UIButton()
    
    
    
    init(annotation: MGLAnnotation) {
        let width = mapsVC.view.frame.width - 32
        super.init(frame: CGRect(x: mapsVC.view.frame.minX, y: mapsVC.view.frame.maxY, width: width, height: 100))
        setupInfoView()
        setupProfileImage()
        setupNameLabel()
        setupLastSeenLabel()
        setupUserInfo(annotation)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func setupUserInfo(_ annotation: MGLAnnotation){
        if let pin = annotation as? AnnotationPin {
            self.pin = pin
            profileImage.loadImage(url: pin.friend.profileImage ?? "")
            actionButton.setImage(UIImage(systemName: "bubble.right"), for: .normal)
            guard let title = annotation.title, let lastSeen = annotation.subtitle else { return }
            nameLabel.text = title
            lastSeenLabel.text = lastSeen
        }else{
            profileImage.loadImage(url: User.profileImage)
            actionButton.setImage(UIImage(systemName: "gear"), for: .normal)
            nameLabel.text = "Me"
            var status: String!
            if User.isMapLocationEnabled ?? false { status = "Anonymous mode is disabled"} else { status = "Anonymous mode is enabled" }
            lastSeenLabel.text = status
        }
    }
    

    
    private func setupInfoView() {
        backgroundColor = .white
        layer.cornerRadius = 16
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.5
        let yValue = mapsVC.view.frame.maxY - 150
        let width = mapsVC.view.frame.width - 32
        frame = CGRect(x: 16, y: yValue, width: width, height: 60)
    }
    

    
    private func setupProfileImage(){
        addSubview(profileImage)
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.layer.cornerRadius = 20
        profileImage.layer.masksToBounds = true
        let constraints = [
            profileImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            profileImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: 40),
            profileImage.heightAnchor.constraint(equalToConstant: 40),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
  
    
    private func setupNameLabel(){
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        let constraints = [
            nameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 8),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -8)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
   
    
    private func setupLastSeenLabel() {
        addSubview(lastSeenLabel)
        lastSeenLabel.translatesAutoresizingMaskIntoConstraints = false
        lastSeenLabel.font = UIFont(name: "Helvetica Neue", size: 14)
        lastSeenLabel.textColor = .lightGray
        let constraints = [
            lastSeenLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 8),
            lastSeenLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 8)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    
    
}
