//
//  CustomTabBar.swift
//  JetChat
//
//  Created by Sana Alshahrani on 09/04/1443 AH.
//

import Foundation
import UIKit


class TabBarCustom: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            barItem(tabBarTitle: "Map", tabBarImage: UIImage(systemName: "mappin")!.withTintColor(.white, renderingMode: .alwaysOriginal), viewController: MapVC()),
            
            barItem(tabBarTitle: "Camera", tabBarImage: UIImage(systemName: "camera")!.withTintColor(.white, renderingMode: .alwaysOriginal), viewController: HomeVC()),
            
            barItem(tabBarTitle: "Chat", tabBarImage: UIImage(systemName: "message")!.withTintColor(.white, renderingMode: .alwaysOriginal), viewController: ChatVC()),
            
            barItem(tabBarTitle: "Profiles", tabBarImage: UIImage(systemName: "message")!.withTintColor(.white, renderingMode: .alwaysOriginal), viewController: ProfileVC())
            
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




