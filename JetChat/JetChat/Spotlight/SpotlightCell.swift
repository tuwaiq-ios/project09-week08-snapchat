//
//  SpotlightCell.swift
//  JetChat
//
//  Created by MacBook on 12/04/1443 AH.
//

import UIKit

 class SpotlightCell: UICollectionViewCell{

     let blogImgCell = UIImageView()
     let titlLbl = UILabel()
     let subTLbl = UILabel()
     let blogLbl = UILabel()
     let writerImg = UIImageView()
     let writerLbl = UILabel()

     override init(frame: CGRect){
         super.init(frame: frame)
         
         self.backgroundColor = .darkGray
         self.contentView.layer.cornerRadius = 20.0
         self.contentView.layer.borderWidth = 2.0
         self.contentView.layer.borderColor = UIColor.clear.cgColor
         self.contentView.layer.masksToBounds = true
         self.contentView.backgroundColor = .white
         self.layer.shadowColor = UIColor.lightGray.cgColor
         self.layer.shadowOffset = CGSize(width: 0, height: 5.0)
         self.layer.shadowRadius = 2.0
         self.layer.shadowOpacity = 2.0
         self.layer.masksToBounds = false
         self.layer.cornerRadius = 2
         self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath

         blogImgCell.translatesAutoresizingMaskIntoConstraints = false
         self.contentView.addSubview(blogImgCell)
         NSLayoutConstraint.activate([
            blogImgCell.rightAnchor.constraint(equalTo: rightAnchor ),
            blogImgCell.leftAnchor.constraint(equalTo: leftAnchor),
            blogImgCell.topAnchor.constraint(equalTo: topAnchor),
            blogImgCell.heightAnchor.constraint(equalToConstant: 400),
         ])
     }

     required init?(coder: NSCoder) {
         super.init(coder: coder)
     }
 }
