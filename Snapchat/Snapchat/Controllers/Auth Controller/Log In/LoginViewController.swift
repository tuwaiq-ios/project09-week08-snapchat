//
//  LoginViewController.swift
//  Snapchat
//
//  Created by Eth Os on 08/04/1443 AH.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    var userServices: UserServices!
    var loginView: LoginView!
    var loginButton: AuthActionButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    private func setupUI(){
        view.backgroundColor = .white
        let _ = GradientView(self)
        loginView = LoginView(self)
        setupLoginButton()
        setupSignUpButton()
    }

    // MARK: TextField Validation
    private func validateTF() -> String?{
        if loginView.emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || loginView.passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Make sure you fill in all fields"
        }
        
        let password = loginView.passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if password.count < 6 {
            return "Password should be at least 6 characters long"
        }
        return nil
    }
    
    
    private func setupLoginButton() {
        loginButton = AuthActionButton("SIGN IN", self)
        view.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        let constraints = [
            loginButton.centerXAnchor.constraint(equalTo: loginView.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: loginView.bottomAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            loginButton.widthAnchor.constraint(equalToConstant: 200)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupSignUpButton() {
        let signUpButton = UIButton(type: .system)
        view.addSubview(signUpButton)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        let mainString = "Don't have an account? Sign Up"
        let stringWithColor = "Sign Up"
        let range = (mainString as NSString).range(of: stringWithColor)
        let attributedString = NSMutableAttributedString(string: mainString)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemBlue, range: range)
        signUpButton.setAttributedTitle(attributedString, for: .normal)
        signUpButton.tintColor = .black
        signUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        signUpButton.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
        let constraints = [
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 8),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: Animation To Sign Up View
    @objc private func signUpButtonPressed() {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            for subview in self.loginView.subviews {
                subview.alpha = 0
            }
            self.loginButton.alpha = 0
        }) { (true) in
            let controller = RegisterViewController()
            controller.modalPresentationStyle = .fullScreen
            controller.logInVC = self
            self.present(controller, animated: false, completion: nil)
        }
    }
    
    
    // MARK: Login Method
    @objc private func loginButtonPressed() {
        loginView.errorLabel.text = ""
        let validation = validateTF()
        if validation != nil {
            loginView.errorLabel.text = validation!
            return
        }
        let password = loginView.passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = loginView.emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        userServices = UserServices(self)
        userServices.signIn(with: email, and: password) { (error) in
            self.loginView.errorLabel.text = error?.localizedDescription
        }
    }
    
    
}
