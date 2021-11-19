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
    }
}


