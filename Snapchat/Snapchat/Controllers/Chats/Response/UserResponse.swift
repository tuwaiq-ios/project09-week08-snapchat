//
//  UserResponse.swift
//  Snapchat
//
//  Created by Fno Khalid on 10/04/1443 AH.
//

import UIKit


class UserResponse {
    

    var responseStatus = false
    
    var repliedMessage: Messages?
    
    var messageToForward: Messages?
    
    var messageSender: String?
    
    let lineView = UIView()
    
    let nameLabel = UILabel()
    
    var nameLabelConstraint: NSLayoutConstraint!
    
    let messageLabel = UILabel()
    
    let mediaMessage = UIImageView()
    
    let audioMessage = UILabel()
    
    let exitButton = UIButton(type: .system)
}
