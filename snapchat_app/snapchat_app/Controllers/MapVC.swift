//
//  MapVC.swift
//  snapchat_app
//
//  Created by dmdm on 18/11/2021.
//

import UIKit
import MapKit
import CoreLocation
import Firebase
import FirebaseFirestore

class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    var locationManager: CLLocationManager!
    var locationManger: CLLocationManager!
    lazy var mapView: MKMapView = {
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
//        let users: Array <Any> = []
//        for user in users {
//            let userPin = MKPointAnnotation()
//            userPin.title = (user as AnyObject).name
//            userPin.coordinate = CLLocationCoordinate2D(
//                latitude: users.lat, longitude: users.long
//            )
//            mapView.addAnnotation(userPin)
//        }
    }
}
func locationManager(_ manager: CLLocationManager,
                     didUpdateLocations location: [CLLocation]) {
    guard let lastLocation = location.last else { return }
    let lat = lastLocation.coordinate.latitude
    let long = lastLocation.coordinate.longitude
    guard let currentUserId = Auth.auth().currentUser?.uid else { return }
    Firestore.firestore().collection("users").document(currentUserId).setData([
        "lat": lat,
        "long": long]
        , merge: true)
}
