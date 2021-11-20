//
//  LoginVC.swift
//  SnapChatGroupC
//
//  Created by sara al zhrani on 07/04/1443 AH.
//
//
//  ViewController.swift
//  MapKKu
//
//  Created by Ahmed Assiri on 06/04/1443 AH.
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
        
        
        let AhmedLocation = MKPointAnnotation()
        AhmedLocation.title = "Ahmed"
        AhmedLocation.coordinate = CLLocationCoordinate2D(latitude: 18.622485, longitude: 42.015544)
        
        mapView.addAnnotation(AhmedLocation)
        
        let AzizLocation = MKPointAnnotation()
        AzizLocation.title = "Aziz"
        AzizLocation.coordinate = CLLocationCoordinate2D(latitude: 18.2464685, longitude: 42.5117238)
        
        mapView.addAnnotation(AzizLocation)
        
        let SaraAliLocation = MKPointAnnotation()
        SaraAliLocation.title = "SaraAli"
        SaraAliLocation.coordinate = CLLocationCoordinate2D(latitude: 18.3093394, longitude: 42.7662325)
        
        mapView.addAnnotation(SaraAliLocation)
        
        let SaraLocation = MKPointAnnotation()
        SaraLocation.title = "SaraM"
        SaraLocation.coordinate = CLLocationCoordinate2D(latitude: 18.2177726, longitude: 42.5387020)
        
        mapView.addAnnotation(SaraLocation)
        
    }
}
