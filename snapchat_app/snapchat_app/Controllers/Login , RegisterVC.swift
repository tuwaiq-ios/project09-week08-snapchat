//
//  Login , RegisterVC.swift
//  snapchat_app
//
//  Created by dmdm on 18/11/2021.
//

import UIKit

class LoginOrRegisterVC: UIViewController {

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "snap")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .black
        
        return imageView
    }()
lazy var loginButton: UIButton = {
    let loginButton = UIButton()
    loginButton.translatesAutoresizingMaskIntoConstraints = false
    loginButton.setTitle("LogIn", for: .normal)
    loginButton.setTitleColor(.black, for: .normal)
    loginButton.backgroundColor = .systemCyan
    loginButton.layer.cornerRadius = 20
    loginButton.layer.masksToBounds = true
    loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    loginButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
    return loginButton
}()
    
    lazy var registerButton: UIButton = {
        let registerButton = UIButton()
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.setTitle("SignUp", for: .normal)
        registerButton.setTitleColor(.black, for: .normal)
        registerButton.backgroundColor = .systemCyan
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
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
          imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         imageView.heightAnchor.constraint(equalToConstant: 250),
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor,multiplier: 100/100)
        ])
        //Constraint loginButton
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
        loginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -70),
        loginButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 100),
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
    
    // make loginButtonTapped works
    @objc private func loginButtonTapped() {
        let vc = LogInVC()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    // make registerButtonTapped works
    @objc private func registerButtonTapped() {
        let vc = RegisterVC()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
