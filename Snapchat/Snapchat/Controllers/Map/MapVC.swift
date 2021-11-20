
//  MapsVC.swift
//  Snapchat
//
//  Created by Jawaher🌻 on 10/04/1443 AH.
//

import UIKit
import Mapbox



class MapsVC: UIViewController, UIGestureRecognizerDelegate{
    

    
    let mapNetworking = MapsNetworking()
    var isFriendSelected = false
    var selectedFriend = FriendInfo()
    var friendCoordinates = [String: CLLocationCoordinate2D]()
    
    var userInfoTab: UserInfoTab?
    let mapView = MGLMapView()
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkStatus()
        userMapHandler()
        
//        setupControllButtons()
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
   
    
    private func checkStatus(){
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            setupMapView()
        case .denied:
            deniedAlertController()
        default:
            break
        }
    }
    
   
    
    func updateMapStyle() {
        mapView.styleURL = URL(string: ThemeColors.selectedMapUrl)
    }
   
 
    
    private func setupMapView(){
        view.addSubview(mapView)
        mapView.frame = view.bounds
           
        mapView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: -8),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        mapView.styleURL = URL(string: ThemeColors.selectedMapUrl)
        mapView.delegate = self
        mapView.allowsRotating = false
        mapView.logoView.isHidden = true
        mapView.showsUserLocation = true
        
    }
  
    
    private func userMapHandler(){
        if !ChatKit.mapTimer.isValid {
            ChatKit.map.showsUserLocation = true
            ChatKit.startUpdatingUserLocation()
        }
    }
    
   
    
   
    
    
    
    @objc func openUserMessagesHandler(){
        let controller = ChatViewController()
        controller.friend = selectedFriend
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    private func presentingVC() -> UIViewController {
        var topController: UIViewController = UIApplication.shared.windows[0].rootViewController!
        while (topController.presentedViewController != nil) {
            topController = topController.presentedViewController!
        }
        return topController
    }
    
    
    private func deniedAlertController(){
        let alertController = UIAlertController(title: "Error", message: "To be able to see the map you need to change your location settings. To do this, go to Settings/Privacy/Location Services/mChat/ and allow location access. ", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alertAction) in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        present(alertController, animated: true, completion: nil)
    }
    
   
    
}

