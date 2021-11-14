//
//  ChatViewController.swift
//  Snapchat
//
//  Created by Eth Os on 08/04/1443 AH.
//

import UIKit
import Firebase
import AVFoundation
import CoreServices
import Lottie

class ChatViewController: UIViewController {
    

    var messages = [Messages]()
    let chatNetworking = ChatNetworking()
    let chatAudio = ChatAudio()
//    var userResponse = UserResponse()
        
    var containerHeight: CGFloat!
    var collectionView: MessageCollectionView!
//    var messageContainer: MessageContainer!
//    var refreshIndicator: MessageLoadingIndicator!
    let blankLoadingView = AnimationView(animation: Animation.named("chatLoadingAnim"))
    
    let calendar = Calendar(identifier: .gregorian)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemMint

        // Do any additional setup after loading the view.
    }
    
}
