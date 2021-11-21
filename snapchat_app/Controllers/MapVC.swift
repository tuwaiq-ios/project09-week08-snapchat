//
//  MapVC.swift
//  snapchat_app
//
//  Created by dmdm on 18/11/2021.
//
//


import UIKit
import MapKit
import FirebaseFirestore
import FirebaseAuth

class MapVC: UIViewController {
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
