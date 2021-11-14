//
//  ChatNetworking.swift
//  Snapchat
//
//  Created by Fno Khalid on 08/04/1443 AH.
//

import UIKit
import AVFoundation
import Firebase


class ChatNetworking {
    
    let audioCache = NSCache<NSString, NSData>()
  
    var loadMore = false
    var lastMessageReached = false
    var messageStatus = "Sent"
    var scrollToIndex = [Messages]()
    var isUserTyping = false
    var chatVC: ChatViewController!
}
