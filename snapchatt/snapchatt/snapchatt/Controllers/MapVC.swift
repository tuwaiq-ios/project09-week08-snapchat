//
//  MapVC.swift
//  snapchatt
//
//  Created by sally asiri on 08/04/1443 AH.
//

import UIKit
import MapKit
import CoreLocation
import Firebase
import FirebaseFirestore


class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate  {
    
    
    var locationManager: CLLocationManager!
    
    
    var locationManger: CLLocationManager!
    
    lazy  var mapView: MKMapView  = {
        let mv = MKMapView()
        mv.translatesAutoresizingMaskIntoConstraints = false
        return mv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        mapView.delegate = self
        
        //made locationServicesEnabled
        if CLLocationManager.locationServicesEnabled() {
            locationManger = CLLocationManager()
            locationManger.delegate = self
            locationManger.desiredAccuracy = kCLLocationAccuracyBest
            locationManger.requestAlwaysAuthorization()
            locationManger.startUpdatingLocation()
        }
        
        // constraint
        view .addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: view.rightAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let users: Array <Any> = []
    }
    
}
// coordinates
    func locationManager(_ manager: CLLocationManager,
        didUpdateLocations location: [CLLocation]) {
        guard let lastLocation = location.last else { return }
        let lat = lastLocation.coordinate.latitude
        let long = lastLocation.coordinate.latitude
        
        
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("users").document(currentUserId).setData([
            "lat": lat,
            "long": long
            
        ], merge: true)
        

    }

