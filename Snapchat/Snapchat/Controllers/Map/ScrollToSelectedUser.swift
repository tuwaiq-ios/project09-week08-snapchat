//
//  ScrollToSelectedUser.swift
//  Snapchat
//
//  Created by Jawaher🌻 on 10/04/1443 AH.
//


import UIKit
import Mapbox



protocol ScrollToSelectedUser {
    func zoomToSelectedFriend(friend: FriendInfo)
}


extension MapsVC: ScrollToSelectedUser {
    

    
    func zoomToSelectedFriend(friend: FriendInfo) {
        selectedFriend = friend
        isFriendSelected = true
    }
    
    

}
