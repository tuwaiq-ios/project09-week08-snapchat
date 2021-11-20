//
//  TabVC.swift
//  SnapChatGroupC
//
//  Created by sara al zhrani on 07/04/1443 AH.
//


import UIKit

class TabBarVC : UITabBarController {
    fileprivate func createNavController(for rootViewController: UIViewController,
                                         title: String,
                                         image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navController
    }
    func setupVCs() {
        
        viewControllers = [
            
            
            createNavController(for:MessageVC(), title: NSLocalizedString("Chat", comment: ""), image: UIImage(systemName: "message")!),
            createNavController(for:locationVC (), title: NSLocalizedString("location", comment: ""), image: UIImage(systemName: "location")!),
            createNavController(for:PeopleVC(), title: NSLocalizedString("Contact", comment: ""), image: UIImage(systemName: "person.3")!),
            createNavController(for:FavoriteVC(), title: NSLocalizedString("Favorite", comment: ""), image: UIImage(systemName: "heart")!),
            createNavController(for:ProfileVC(), title: NSLocalizedString("Profile", comment: ""), image: UIImage(systemName: "person")!),
        ]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemGray6
        tabBar.tintColor = .label
        setupVCs()
        
        
        view.isUserInteractionEnabled = true
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
            swipeLeft.direction = .left
            self.view.addGestureRecognizer(swipeLeft)
                
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
            swipeRight.direction = .right
            self.view.addGestureRecognizer(swipeRight)
                
            let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
            swipeUp.direction = .up
            self.view.addGestureRecognizer(swipeUp)
                
            let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
            swipeDown.direction = .down
            self.view.addGestureRecognizer(swipeDown)
        
    }
        
        @objc func handleGesture(gesture: UISwipeGestureRecognizer) {
           if gesture.direction == .right {
               present(
                   UINavigationController(rootViewController: CamVC()),
                   animated: true,
                   completion: nil
               )
           }
           else if gesture.direction == .left {
        
                   present(
                       UINavigationController(rootViewController: ViewController()),
                       animated: true,
                       completion: nil)
              
           }
           else if gesture.direction == .up {
                print("Swipe Up")
           }
           else if gesture.direction == .down {
                print("Swipe Down")
           }
        }
        
        
        
    }

                       

