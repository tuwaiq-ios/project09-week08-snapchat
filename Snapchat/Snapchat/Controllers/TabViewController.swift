//
//  TabViewController.swift
//  Snapchat
//
//  Created by Eth Os on 08/04/1443 AH.
//

import UIKit

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = .systemBackground
           UITabBar.appearance().barTintColor = .systemBackground
           tabBar.tintColor = .label
           setupVCs()
        
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                         image: UIImage) -> UIViewController {
          let navController = UINavigationController(rootViewController: rootViewController)
          navController.tabBarItem.image = image
          navController.navigationBar.prefersLargeTitles = true
          rootViewController.navigationItem.title = title
          return navController
      }
    
    func setupVCs() {
          viewControllers = [
            createNavController(for: ContactsViewController(), image: UIImage(systemName: "person.3.fill")!),
            createNavController(for: ConversationViewController(),image: UIImage(systemName: "message.fill")!),
            createNavController(for: CameraViewController(), image: UIImage(systemName: "camera.fill")!),
              createNavController(for: LocationViewController(), image: UIImage(systemName: "map.fill")!),
              createNavController(for: ProfileViewController(), image: UIImage(systemName: "person.fill")!)
          ]
      }
}
