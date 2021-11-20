//
//  TabVC.swift
//  snapchatt
//
//  Created by sally asiri on 08/04/1443 AH.
//
import UIKit


class TabVC: UITabBarController {
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
        createNavController(for:UsersVC (), title: NSLocalizedString("Users", comment: ""), image: UIImage(systemName: "person.3")!),
        createNavController(for:ConversationVC (), title: NSLocalizedString("Conversation", comment: ""), image: UIImage(systemName: "message")!),
   //     createNavController(for:ChatVC(), title: NSLocalizedString("Chat", comment: ""), image: UIImage(systemName: "message")!),
		createNavController(for:CamVC(), title: NSLocalizedString("Cam", comment: ""), image: UIImage(systemName: "camera")!),
       createNavController(for:MapVC(), title: NSLocalizedString("Location", comment: ""), image: UIImage(systemName: "location")!),
       createNavController(for:MyProfileVC(), title: NSLocalizedString("Profile", comment: ""), image: UIImage(systemName: "person")!),
		

     ]
   }
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
      UITabBar.appearance().barTintColor = .systemBackground
      tabBar.tintColor = .label
      setupVCs()
    
  }
}

