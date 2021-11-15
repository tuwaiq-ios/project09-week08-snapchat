//
//  TabVC.swift
//  SnnapChatApp
//
//  Created by dmdm on 15/11/2021.
//

import UIKit
import Firebase
    
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
  override func viewDidLoad() {
    super.viewDidLoad()
//    delegate = self
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    let item1 = UsersViewController()
    let item2 = ProfileVC()
    let item3 = LocationVC()
//      let item4 = CamVC()
    let icon1 = UITabBarItem(title: "chat", image: UIImage(systemName: "contextualmenu.and.cursorarrow"), selectedImage: UIImage(systemName: "contextualmenu.and.cursorarrow"))
      
    let icon2 = UITabBarItem(title: "profile", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person"))
      
      let icon3 = UITabBarItem(title: "Location", image: UIImage(systemName: "location"), selectedImage: UIImage(systemName: "location"))
//      let icon4 = UITabBarItem(title: "Camera", image: UIImage(systemName: "camera"), selectedImage: UIImage(systemName: "camera"))
      
    item1.tabBarItem = icon1
    item2.tabBarItem = icon2
    item3.tabBarItem = icon3
//    item4.tabBarItem = icon4
    let controllers = [item1,item2,item3] //array of the root view controllers displayed by the tab bar interface
    self.viewControllers = controllers
  }
  func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
    print("Should select viewController: \(viewController.title ?? "") ?")
    return true;
  }
}
