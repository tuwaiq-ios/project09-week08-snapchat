//
//  TabBarController.swift
//  TuwaiqChat
//
//  Created by Maram Al shahrani on 11/04/1443 AH.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            
            barItem(tabBarTitle: "Chat", tabBarImage: UIImage(systemName: "message")!.withTintColor(.white, renderingMode: .alwaysOriginal), viewController: MainVC()),
            
            barItem(tabBarTitle: "Camera", tabBarImage: UIImage(systemName: "camera")!.withTintColor(.white, renderingMode: .alwaysOriginal), viewController: CameraVC()),
            
            barItem(tabBarTitle: "Map", tabBarImage: UIImage(systemName: "mappin")!.withTintColor(.white, renderingMode: .alwaysOriginal), viewController: MapVC()),
            
        ]
        
        tabBar.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        tabBar.isTranslucent = false
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        tabBar.unselectedItemTintColor = .white
        
        selectedIndex   = 1
    }
    
    private func barItem(tabBarTitle: String, tabBarImage: UIImage, viewController: UIViewController) -> UINavigationController {
        let navCont = UINavigationController(rootViewController: viewController)
        navCont.tabBarItem.title = tabBarTitle
        navCont.tabBarItem.image = tabBarImage
        return navCont
    }
    
}
