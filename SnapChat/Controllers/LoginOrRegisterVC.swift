//
//  LoginOrRegisterVC.swift
//  SnapChat
//
//  Created by sara saud on 11/14/21.
//

import UIKit

class LoginOrRegisterVC: UIViewController {

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Snap")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .black
        imageView.layer.cornerRadius = 25
        
        return imageView
    }()
lazy var loginButton: UIButton = {
    let loginButton = UIButton()
    loginButton.translatesAutoresizingMaskIntoConstraints = false
    loginButton.setTitle(NSLocalizedString("Log In", comment: ""), for: .normal)
    loginButton.setTitleColor(.white, for: .normal)
    loginButton.backgroundColor = .systemPink
    loginButton.layer.cornerRadius = 0
    loginButton.layer.masksToBounds = true
    loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    loginButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
    return loginButton
}()
    
    lazy var registerButton: UIButton = {
        let registerButton = UIButton()
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.setTitle(NSLocalizedString("Sign In", comment: ""), for: .normal)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.backgroundColor = .systemBlue
        registerButton.layer.cornerRadius = 0
        registerButton.layer.masksToBounds = true
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        registerButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        return registerButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
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
            loginButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 300),
//            loginButton.bottomAnchor.constraint(equalTo: registerButton.topAnchor),

            loginButton.rightAnchor.constraint(equalTo: view.rightAnchor),
            loginButton.leftAnchor.constraint(equalTo: view.leftAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 100),
        ])
        
        //Constraint registerButton
        view.addSubview(registerButton)
        NSLayoutConstraint.activate([
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor),
            registerButton.rightAnchor.constraint(equalTo: view.rightAnchor),
            registerButton.leftAnchor.constraint(equalTo: view.leftAnchor),
            registerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            registerButton.heightAnchor.constraint(equalToConstant: 100),
        ])
            }
    
    @objc private func loginButtonTapped() {
        let vc = LogInVC()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc private func registerButtonTapped() {
        let vc = RegisterVC()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
