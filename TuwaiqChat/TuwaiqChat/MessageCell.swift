//
//  MessageCell.swift
//  TuwaiqChat
//
//  Created by PC on 09/04/1443 AH.
//

import UIKit


class MessageCell : UITableViewCell {
    
    var MainViewTrailingAnchor = NSLayoutConstraint()
    var MainViewLeadingAnchor = NSLayoutConstraint()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        
        addSubview(mainView)
        mainView.addSubview(bubbleImage)
        mainView.addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            mainView.widthAnchor.constraint(equalToConstant: 250),
            
            bubbleImage.topAnchor.constraint(equalTo: mainView.topAnchor),
            bubbleImage.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            bubbleImage.leftAnchor.constraint(equalTo: mainView.leftAnchor),
            bubbleImage.rightAnchor.constraint(equalTo: mainView.rightAnchor),
            
            messageLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10),
            messageLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -10),
            messageLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 20),
            messageLabel.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -20),
            
        ])
        
        MainViewTrailingAnchor = mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5)
        MainViewLeadingAnchor = mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5)
    }
    
    
    let mainView : UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 8
        return $0
    }(UIView())
    
    lazy var bubbleImage : UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleToFill
        return $0
    }(UIImageView())
    
    
    let messageLabel : UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 0
        $0.textAlignment = .right
        $0.textColor = UIColor.white.withAlphaComponent(0.8)
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        return $0
    }(UILabel())
    
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
