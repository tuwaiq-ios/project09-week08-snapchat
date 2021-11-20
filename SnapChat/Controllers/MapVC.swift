//
//  MapVC.swift
//  SnapChat
//
//  Created by Amal on 04/04/1443 AH.
//

import UIKit
import MapKit
class MapVC: UIViewController {
    let mapView : MKMapView = {
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
        A.title = "Amal"
        A.coordinate = CLLocationCoordinate2D(latitude: 24.5246542, longitude: 39.5691841)
        mapView.addAnnotation(A)
        let S = MKPointAnnotation()
        S.title = "Sara"
        S.coordinate = CLLocationCoordinate2D(latitude: 24.7135517, longitude: 46.6752957)
        mapView.addAnnotation(S)
        let F = MKPointAnnotation()
        F.title = "Fawaz"
        F.coordinate = CLLocationCoordinate2D(latitude: 18.084764, longitude: 43.138569)
        mapView.addAnnotation(F)
    }
}
