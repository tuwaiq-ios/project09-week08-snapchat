//
//  File.swift
//  SnapChat
//
//  Created by Fawaz on 19/11/2021.
//

import UIKit
import FirebaseFirestore

class LocationService {
  
  static let shared = LocationService()
  
  let locationsCollection = Firestore.firestore().collection("locations")
  
  func updateOrAddLocation(location_UpAd: Location_struct) {
    locationsCollection.document(location_UpAd.id).setData([
      "id": location_UpAd.id,
      "location": location_UpAd.location,
      "size": location_UpAd.size
    ], merge: true)
  }
  
  func listenToNotes(completion: @escaping (([Location_struct]) -> Void)) {
    locationsCollection.addSnapshotListener { snapshot, error in
      if error != nil {
        return
      }
      
      guard let docs = snapshot?.documents else { return }
      
      var locations_guard = [Location_struct]()
      
      for doc in docs {
        let data = doc.data()
        guard
          /*
           var id: String
           var location: CLLocation
           var size: CGSize
           */
          let id = data["id"] as? String,
          let location = data["location"] as? String,
          let size = data["size"] as? String
        else {
          continue
        }
        
//        locations_guard.append(Location_struct(id: id, location: LocationService, size: CGSize))
      }
      completion(locations_guard)
    }
  }
}


