//
//  TabVC.swift
//  SnapChat
//
//  Created by Amal on 04/04/1443 AH.
//

import UIKit


class TabVC: UITabBarController {
  fileprivate func createNavController(for rootViewController: UIViewController,
                           title: String,
                           image: UIImage) -> UIViewController {
      // titel in all views
      let navController = UINavigationController(rootViewController: rootViewController)
      navController.tabBarItem.title = title
      navController.tabBarItem.image = image
      navController.navigationBar.prefersLargeTitles = true
      rootViewController.navigationItem.title = title
      return navController
    }
  func setupVCs() {
     viewControllers = [
        createNavController(for:MapVC (), title: NSLocalizedString("location", comment: ""), image: UIImage(systemName: "location")!),
        createNavController(for:ConversationVC(), title: NSLocalizedString("Chat", comment: ""), image: UIImage(systemName: "message")!),
        createNavController(for:CamVC(), title: NSLocalizedString("cam", comment: ""), image: UIImage(systemName: "camera")!),
       createNavController(for:UsersVC(), title: NSLocalizedString("Users", comment: ""), image: UIImage(systemName: "person.3")!),
       createNavController(for:MyProfileVC(), title: NSLocalizedString("profile", comment: ""), image: UIImage(systemName: "person")!),

     ]
   }
  override func viewDidLoad() {
    super.viewDidLoad()
      view.backgroundColor = UIColor (named: "myBackgroundColor")
      UITabBar.appearance().barTintColor = .systemBackground
      tabBar.tintColor = .label
      setupVCs()
    
  }
}
