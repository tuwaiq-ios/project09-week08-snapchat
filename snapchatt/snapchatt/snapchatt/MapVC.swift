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
        
        if CLLocationManager.locationServicesEnabled() {
            locationManger = CLLocationManager()
            locationManger.delegate = self
            locationManger.desiredAccuracy = kCLLocationAccuracyBest
            locationManger.requestAlwaysAuthorization()
            locationManger.startUpdatingLocation()
        }
        
        view .addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: view.rightAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let users: Array <Any> = []
    }
    
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//
//
//        guard let location = locations.last else {return}
//        let lat = location.coordinate.latitude
//        let long = location.coordinate.longitude
//
//
//        let loc = MKPointAnnotation()
//        loc.title = "Asir"
//        loc.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
//        mapView.addAnnotation(loc)
//    }
//


    }
//extension ViewController: MKMapViewDelegate, CLLocationManagerDelegate {
    
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

