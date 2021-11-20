//
//  AnnotationPin.swift
//  Snapchat
//
//  Created by Jawaher🌻 on 10/04/1443 AH.
//


import Mapbox

class AnnotationPin: MGLPointAnnotation {
    
 
    var friend: FriendInfo!
    let calendar = Calendar(identifier: .gregorian)

    init(_ coordinate: CLLocationCoordinate2D, _ friend: FriendInfo) {
        super.init()
        self.friend = friend
        self.coordinate = coordinate
        self.title = friend.name
        if friend.isOnline ?? false {
            self.subtitle = "Online"
        }else{
            let date = Date(timeIntervalSince1970: (friend.lastLogin ?? 0).doubleValue)
            self.subtitle = calendar.calculateLastLogin(date as NSDate)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
