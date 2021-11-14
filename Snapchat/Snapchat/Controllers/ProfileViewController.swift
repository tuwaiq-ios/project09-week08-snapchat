//
//  ProfileViewController.swift
//  Snapchat
//
//  Created by Eth Os on 08/04/1443 AH.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    let logoutButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        navigationItem.title = "Profile"
        // Do any additional setup after loading the view.
        setupLeftNavButton()
    }
    
    private func setupLeftNavButton(){
        logoutButton.setTitle("Sign out", for: .normal)
        logoutButton.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 18)
        logoutButton.setTitleColor(.systemRed, for: .normal)
        logoutButton.addTarget(self, action: #selector(setupLogoutView), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: logoutButton)
    }
    
    @objc private func setupLogoutView() {
        let alert = UIAlertController(title: "Sign Out", message: "Are you sure you want to sign out?", preferredStyle: .alert)
        let exitAction = UIAlertAction(title: "Exit", style: .destructive) { (true) in
            self.logoutButtonPressed()
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(exitAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func logoutButtonPressed(){
        
        UserActivity.observe(isOnline: false)
            do{
                try Auth.auth().signOut()
                let vc = LoginViewController()
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
                
            }catch{
                print("Faild to log out")
            }
    
    }
}
