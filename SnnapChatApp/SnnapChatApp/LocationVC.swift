//
//  LocationVC.swift
//  SnnapChatApp
//
//  Created by Hanan on 15/11/2021.
//

import UIKit
import MapKit
import FirebaseFirestore
import FirebaseAuth

class LocationVC: UIViewController {
    let mapView = MKMapView()



    override func viewDidLoad() {
        super.viewDidLoad()


        let Asir = MKPointAnnotation()
            Asir.title = "Me"
            Asir.coordinate = CLLocationCoordinate2D(latitude: 18.2497107, longitude: 42.4584669)
        mapView.addAnnotation(Asir)
        setupMapView()
    }

    func setupMapView() {
        view.addSubview(mapView)

        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mapView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        mapView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true


    }
    
   
   // extension LocationVC: MKMapViewDelegate , CLLocationManagerDelegate {
                                
   func locationManager(_ manger: CLLocationManager, didUpdateLocation location: [CLLocation]) {
            guard let lastLocation = location.last else { return }
            
            let lat = lastLocation.coordinate.latitude
            let long = lastLocation.coordinate.longitude
            
            guard let currentUserId = Auth.auth().currentUser?.uid else {return }
            Firestore.firestore().collection("users").document(currentUserId).setData([
                "lat": lat,
                "long": long
            ], merge: true)

    }
}


//
//
//import UIKit
//import MapKit
//import FirebaseFirestore
//import FirebaseAuth
//
//class LocationVC: UIViewController {
//
//    var locationManeger: UIViewController!
//
//    lazy var mapView:  MKMapView = {
//        let mv = MKMapView()
//        mv.translatesAutoresizingMaskIntoConstraints = false
//       // mv.delegate = self
//        return mv
//    }()
//
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        if (CLLocationManager.locationServicesEnabled())
//        {
////            locationManeger = CLLocationManager()
////            locationManeger.delegate = self
////            locationManeger.desiredAccuracy = kCLLocationAccuracyBest
////            locationManeger.requestAlwaysAuthorization()
////            locationManeger.startUpdatingLocation()
//        }
//        view.addSubview(mapView)
//
//        NSLayoutConstraint.activate([
//        mapView.topAnchor.constraint(equalTo: view.topAnchor),
//        //mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//        mapView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
//        mapView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor)
//        ])
//
//    }
//
//        let users: Array <Any> = []
//
//    func LocationVC(_ manger: CLLocationManager, didUpdateLocation location: [CLLocation]) {
//            guard let lastLocation = location.last else { return }
//
//            let lat = lastLocation.coordinate.latitude
//            let long = lastLocation.coordinate.longitude
//
//            guard let currentUserId = Auth.auth().currentUser?.uid else {return }
//            Firestore.firestore().collection("users").document(currentUserId).setData([
//                "lat": lat,
//                "long": long
//            ], merge: true)
//     }
//    }
//

