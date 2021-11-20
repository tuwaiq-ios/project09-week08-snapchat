//
//  CurrentUserAnnotationView.swift
//  Snapchat
//
//  Created by Jawaher🌻 on 10/04/1443 AH.
//


import UIKit
import Mapbox
import FirebaseAuth

class CurrentUserAnnotationView: MGLUserLocationAnnotationView {


    
    let size: CGFloat = 32
    let imageLayer = CALayer()
    
    
    override func update() {
        if frame.isNull {
            frame = CGRect(x: 0, y: 0 , width: size, height: size)
            return setNeedsLayout()
        }
        imageLayer.bounds = CGRect(x: 0, y: 0, width: size, height: size)
        let imageView = UIImageView()
        guard User.profileImage != nil else { return }
        imageView.loadImage(url: User.profileImage)
        imageLayer.contents = imageView.image?.cgImage
        imageLayer.cornerRadius = imageLayer.frame.size.width/2
        imageLayer.masksToBounds = true
        imageLayer.borderWidth = 2
        imageLayer.borderColor = UIColor.white.cgColor
        layer.addSublayer(imageLayer)
    }
    
   
    
}
