//
//  RegisterViewController.swift
//  Snapchat
//
//  Created by Eth Os on 08/04/1443 AH.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {

    var logInVC: LoginViewController!
    var backButton: AuthBackButton!
    var continueButton: AuthActionButton!
    var registerView: RegisterView!
    
    var userServices: UserServices!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI() 
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        setupGradientView()
        setupRegisterView()
        setupContinueButton()
        setupBackButton()
    }
    
    private func setupGradientView() {
        let _ = GradientView(self)
    }
    
    private func setupRegisterView() {
        registerView = RegisterView(self)
    }
    
    private func setupContinueButton() {
        continueButton = AuthActionButton("CONTINUE", self)
        view.addSubview(continueButton)
        continueButton.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)
        continueButton.alpha = 0
        let constraints = [
            continueButton.centerXAnchor.constraint(equalTo: registerView.centerXAnchor),
            continueButton.centerYAnchor.constraint(equalTo: registerView.bottomAnchor),
            continueButton.heightAnchor.constraint(equalToConstant: 40),
            continueButton.widthAnchor.constraint(equalToConstant: 200)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupBackButton() {
        backButton = AuthBackButton(self)
        backButton.alpha = 0
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
    
    @objc private func backButtonPressed() {
        dismiss(animated: false) {
           // sign in
            self.logInVC.returnToSignInVC()
        }
    }
    
    private func validateTF() -> String?{
        if registerView.nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || registerView.emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || registerView.passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Make sure you fill in all fields."
        }
        
        let password = registerView.passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let name = registerView.nameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = registerView.emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if password.count < 6 {
            return "Password should be at least 6 characters long."
        }
        
        if name.count > 30 {
            return "Your name exceeds a limit of 30 characters."
        }
        
        if email.count > 30 {
            return "Your email exceeds a limit of 30 characters."
        }
        
        
        return nil
    }
    
    @objc private func continueButtonPressed() {
        registerView.errorLabel.text = ""
        let validation = validateTF()
        if validation != nil {
            registerView.errorLabel.text = validation
            return
        }
        let email = registerView.emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        userServices = UserServices(self)
        userServices.checkForExistingEmail(email) { (errorMessage) in
            guard errorMessage == nil else {
                self.registerView.errorLabel.text = errorMessage
                return
            }
            self.goToNextController()
        }
    }
    
    
    
    private func goToNextController(){
        let name = registerView.nameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = registerView.emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = registerView.passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let controller = SelectProfileImageViewController()
        controller.modalPresentationStyle = .fullScreen
        controller.name = name
        controller.email = email
        controller.password = password
        self.show(controller, sender: nil)
    }
    
    
}
