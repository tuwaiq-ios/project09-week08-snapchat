//
//  MapVC.swift
//  SnapChat
//
//  Created by Amal on 04/04/1443 AH.
//

//import UIKit
//import MapKit
//import CoreLocation
//
//class MapVC: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
//
//    var locationManger: CLLocationManager!
//
//    lazy  var mapView: MKMapView  = {
//        let mv = MKMapView()
//        mv.translatesAutoresizingMaskIntoConstraints = false
//        return mv
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//        mapView.delegate = self
//
//        if (CLLocationManager.locationServicesEnabled())
//        {
//            locationManger = CLLocationManager()
//            locationManger.delegate = self
//            locationManger.desiredAccuracy = kCLLocationAccuracyBest
//            locationManger.requestAlwaysAuthorization()
//            locationManger.startUpdatingLocation()
//        }
//
//        view .addSubview(mapView)
//        NSLayoutConstraint.activate([
//            mapView.leftAnchor.constraint(equalTo: view.leftAnchor),
//            mapView.rightAnchor.constraint(equalTo: view.rightAnchor),
//            mapView.topAnchor.constraint(equalTo: view.topAnchor),
//            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//
//    }
//
//
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
//}


import UIKit
import FirebaseFirestore
import Firebase
import MapKit

class MapVC: UIViewController {
  var locationManager = CLLocationManager()
  lazy var mapView : MKMapView = {
    let mv = MKMapView()
    mv.delegate = self
    mv.translatesAutoresizingMaskIntoConstraints = false
    return mv
    
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(mapView)
    NSLayoutConstraint.activate([
      mapView.topAnchor.constraint(equalTo: view.topAnchor),
      mapView.rightAnchor.constraint(equalTo: view.rightAnchor),
      mapView.leftAnchor.constraint(equalTo: view.leftAnchor),
      mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    setMapConstraints()
  }
  func setMapConstraints() {
    if CLLocationManager.locationServicesEnabled(){
      locationManager=CLLocationManager()
      locationManager.delegate = self
      locationManager.desiredAccuracy=kCLLocationAccuracyBest
      locationManager.requestAlwaysAuthorization()
      locationManager.startUpdatingLocation()
    }
  }
}
extension MapVC: MKMapViewDelegate , CLLocationManagerDelegate{
  
  func locationManager(_ manager: CLLocationManager,
                       didUpdateLocations location: [CLLocation] ){
    
    print("jhgdfghjk")
    
    guard let lastLocation = location.last else{ return }
    let lat = lastLocation.coordinate.latitude
    let loge = lastLocation.coordinate.longitude
    let myloaction = MKPointAnnotation()
    myloaction.title = "Fawaz"
    myloaction.coordinate = CLLocationCoordinate2D(
      latitude: lat,
      longitude: loge
    )
    mapView.addAnnotation(myloaction)
  }
}
