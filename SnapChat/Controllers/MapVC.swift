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


//import UIKit
//import FirebaseFirestore
//import Firebase
//import MapKit
//
//class MapVC: UIViewController {
//  var locationManager = CLLocationManager()
//  lazy var mapView : MKMapView = {
//    let mv = MKMapView()
//    mv.delegate = self
//    mv.translatesAutoresizingMaskIntoConstraints = false
//    return mv
//
//  }()
//
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    view.addSubview(mapView)
//    NSLayoutConstraint.activate([
//      mapView.topAnchor.constraint(equalTo: view.topAnchor),
//      mapView.rightAnchor.constraint(equalTo: view.rightAnchor),
//      mapView.leftAnchor.constraint(equalTo: view.leftAnchor),
//      mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//    ])
//    setMapConstraints()
//  }
//  func setMapConstraints() {
//    if CLLocationManager.locationServicesEnabled(){
//      locationManager=CLLocationManager()
//      locationManager.delegate = self
//      locationManager.desiredAccuracy=kCLLocationAccuracyBest
//      locationManager.requestAlwaysAuthorization()
//      locationManager.startUpdatingLocation()
//    }
//  }
//}
//extension MapVC: MKMapViewDelegate , CLLocationManagerDelegate{
//
//  func locationManager(_ manager: CLLocationManager,
//                       didUpdateLocations location: [CLLocation] ){
//
//    print("jhgdfghjk")
//
//    guard let lastLocation = location.last else{ return }
//    let lat = lastLocation.coordinate.latitude
//    let loge = lastLocation.coordinate.longitude
//    let myloaction = MKPointAnnotation()
//    myloaction.title = "Fawaz"
//    myloaction.coordinate = CLLocationCoordinate2D(
//      latitude: lat,
//      longitude: loge
//    )
//    mapView.addAnnotation(myloaction)
//  }
//}
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
