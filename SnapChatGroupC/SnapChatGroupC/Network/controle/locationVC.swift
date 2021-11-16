//
//  LoginVC.swift
//  SnapChatGroupC
//
//  Created by sara al zhrani on 07/04/1443 AH.
//

import UIKit
import MapKit






class locationVC: UIViewController {
    
    
    let  mapView : MKMapView = {
        
        let map = MKMapView()
        
        map.overrideUserInterfaceStyle = .light
        
        return map
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        setMapConstraints()
        
    }
    
    func setMapConstraints() {
        view.addSubview(mapView)
        
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        
        
        let A = MKPointAnnotation()
        A.title = "Ahmed"
        A.coordinate = CLLocationCoordinate2D(latitude: 24.5246542, longitude: 39.5691841)
        
        mapView.addAnnotation(A)
        
        
        let AZ = MKPointAnnotation()
        AZ.title = "Aziz"
        AZ.coordinate = CLLocationCoordinate2D(latitude: 24.7135517, longitude: 46.6752957)
        mapView.addAnnotation(AZ)
        
        
        let SZ = MKPointAnnotation()
        SZ.title = "Sara Ali"
        SZ.coordinate = CLLocationCoordinate2D(latitude: 18.084764, longitude: 43.138569)
        
        mapView.addAnnotation(SZ)
        
        
        let SM = MKPointAnnotation()
        SM.title = "Sara"
        SM.coordinate = CLLocationCoordinate2D(latitude: 21.41667, longitude: 39.81667)
        
        mapView.addAnnotation(SM)
    }
    
    
    
    
}




//extension ViewController : MKMapViewDelegate, CLLocationManagerDelegate  {

//  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

//  guard let lastLocations: [CLLocation]) {
//
//  }
//  }



//}

