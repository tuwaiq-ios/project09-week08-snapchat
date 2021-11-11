//
//  ViewController.swift
//  SnapChat
//
//  Created by Amal on 04/04/1443 AH.
//

import UIKit

class LognVC: UIViewController {

      lazy var userEmail: UITextField = {
        let userEmail = UITextField()
          userEmail.translatesAutoresizingMaskIntoConstraints = false
          userEmail.layer.cornerRadius = 12
          userEmail.layer.borderWidth = 1
          userEmail.layer.borderColor = UIColor.lightGray.cgColor
          userEmail.placeholder = "  Email Address..."
          userEmail.backgroundColor = .secondarySystemBackground
        return userEmail
    }()

    lazy var userPassword: UITextField = {
        let userPassword = UITextField()
        userPassword.translatesAutoresizingMaskIntoConstraints = false
        userPassword.layer.cornerRadius = 12
        userPassword.layer.borderWidth = 1
        userPassword.layer.borderColor = UIColor.lightGray.cgColor
        userPassword.placeholder = "  Password..."
        userPassword.backgroundColor = .secondarySystemBackground
        return userPassword
    }()

    lazy var loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("Log In", for: .normal)
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.backgroundColor = .yellow
        loginButton.layer.cornerRadius = 12
        loginButton.layer.masksToBounds = true
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        return loginButton
    }()
    lazy var labelToRegister: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.text = "Don't have account?  "
        return label
    }()
    lazy var registerButton: UIButton = {
        let registerButton = UIButton()
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.setTitle("Sign up", for: .normal)
        registerButton.setTitleColor(.blue, for: .normal)
        registerButton.backgroundColor = .white
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        registerButton.titleLabel?.font = .systemFont(ofSize: 12, weight: .medium)
        return registerButton
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Snap")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .black
        
        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Log In"
        
        //Constraint imageView
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -145),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),
        ])
        //Constraint userEmail
        view.addSubview(userEmail)
        NSLayoutConstraint.activate([
            userEmail.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            userEmail.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 80),
            userEmail.widthAnchor.constraint(equalToConstant: 350),
            userEmail.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        //Constraint userPassword
        view.addSubview(userPassword)
        NSLayoutConstraint.activate([
            userPassword.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            userPassword.topAnchor.constraint(equalTo: userEmail.bottomAnchor, constant: 16),
            userPassword.widthAnchor.constraint(equalToConstant: 350),
            userPassword.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        //Constraint loginButton
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -45),
            loginButton.topAnchor.constraint(equalTo: userPassword.bottomAnchor, constant: 16),
            loginButton.widthAnchor.constraint(equalToConstant: 300),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        //Constraint labelToRegister
        view.addSubview(labelToRegister)
        NSLayoutConstraint.activate([
            labelToRegister.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -35),
            labelToRegister.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 40),
            labelToRegister.widthAnchor.constraint(equalToConstant: 300),
            labelToRegister.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        //Constraint registerButton
        
        view.addSubview(registerButton)
        NSLayoutConstraint.activate([
            registerButton.rightAnchor.constraint(equalTo: labelToRegister.leftAnchor, constant: 170),
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 40),
            registerButton.widthAnchor.constraint(equalToConstant: 50),
            registerButton.heightAnchor.constraint(equalToConstant: 40),
        ])
        
    }
    
    @objc private func loginButtonTapped() {
            let vc = TabVC()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    
    @objc private func registerButtonTapped() {
        let vc = RegisterVC()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }

}

