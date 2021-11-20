//
//  MapVC.swift
//  TuwaiqChat
//
//  Created by Maram Al shahrani on 11/04/1443 AH.
//

import UIKit
import MapKit
import Firebase

struct Location {
    var lat : Double?
    var long : Double?
}

class MapVC : UIViewController {
    
    var annotations = [MKPointAnnotation]()
    
    var locations = [Location]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground()
        
        view.addSubview(mapView)
        getUsersLocations {
            for i in self.locations {
                let annotation = MKPointAnnotation()
                if let lat = i.lat , let long = i.long {
                    annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(long))
                    self.annotations.append(annotation)
                    self.mapView.addAnnotations(self.annotations)
                }
            }
        }
        
        
    }
    
    lazy var mapView : MKMapView = {
        $0.frame = self.view.bounds
        return $0
    }(MKMapView())
    
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }

        return annotationView
    }
    
    
    
    func getUsersLocations(completion : @escaping () -> ())  {
        Firestore.firestore().collection("Users").addSnapshotListener { snapshot, error in
            self.locations.removeAll()
            if error == nil {
                if let value = snapshot?.documents {
                    for user in value {
                        let userData = user.data()
                                                    
                        self.locations.append(Location(lat: userData["userLatitude"] as? Double, long: userData["userLongtude"] as? Double))
                        
                    }
                    print(self.locations)
                    completion()
                }
            }
        }
    }
    
    
}
