//
//  LoginOrRegisterVC.swift
//  SnapChat
//
//  Created by Amal on 05/04/1443 AH.
//

import UIKit

class LoginOrRegisterVC: UIViewController {

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Snap")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .black
        
        return imageView
    }()
lazy var loginButton: UIButton = {
    let loginButton = UIButton()
    loginButton.translatesAutoresizingMaskIntoConstraints = false
    loginButton.setTitle("Log In", for: .normal)
    loginButton.setTitleColor(.black, for: .normal)
    loginButton.backgroundColor = .yellow
    loginButton.layer.cornerRadius = 20
    loginButton.layer.masksToBounds = true
    loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    loginButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
    return loginButton
}()
    
    lazy var registerButton: UIButton = {
        let registerButton = UIButton()
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.setTitle("Sing up", for: .normal)
        registerButton.setTitleColor(.black, for: .normal)
        registerButton.backgroundColor = .yellow
        registerButton.layer.cornerRadius = 20
        registerButton.layer.masksToBounds = true
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        registerButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        return registerButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        //Constraint imageView
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -145),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 240),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),
        ])
        //Constraint loginButton
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -70),
            loginButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 80),
            loginButton.widthAnchor.constraint(equalToConstant: 240),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            
        ])
        //Constraint registerButton
        view.addSubview(registerButton)
        NSLayoutConstraint.activate([
            registerButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -70),
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 30),
            registerButton.widthAnchor.constraint(equalToConstant: 240),
            registerButton.heightAnchor.constraint(equalToConstant: 40),
        ])
            }
    
    @objc private func loginButtonTapped() {
        let vc = LognVC()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc private func registerButtonTapped() {
        let vc = RegisterVC()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
