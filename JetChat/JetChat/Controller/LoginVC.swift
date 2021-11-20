//
//  Login.swift
//  JetChat
//
//  Created by MacBook on 08/04/1443 AH.
//

import UIKit
import Firebase
import FirebaseAuth

class Login: UITableViewController {
    
    let db = Firestore.firestore()
    
    let containerV = UIView()
    let registerBtn = UIButton()
    let nameTF = UITextField()
    let nameSeparatorV = UIView()
    let emailTF = UITextField()
    let emailSeparatorV = UIView()
    let passTf = UITextField()
    let profilImg = UIImageView()
    var loginRegstSg = UISegmentedControl()
    let label = UILabel()
    
    var containerHeight: NSLayoutConstraint?
    var nameTFHeight: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        nameTF.text = "Ibrahim".localized()
        nameTF.placeholder = "Your Name".localized()
        nameTF.textAlignment = .center
        nameTF.translatesAutoresizingMaskIntoConstraints = false
        nameSeparatorV.translatesAutoresizingMaskIntoConstraints = false
        nameSeparatorV.backgroundColor = .lightGray
        
        emailTF.text = "ibra3@i.com"
        emailTF.placeholder = "Email".localized()
        emailTF.textAlignment = .center
        emailTF.translatesAutoresizingMaskIntoConstraints = false
        emailSeparatorV.translatesAutoresizingMaskIntoConstraints = false
        emailSeparatorV.backgroundColor = .lightGray
        
        passTf.text = "123456"
        passTf.placeholder = "Password".localized()
        passTf.textAlignment = .center
        passTf.translatesAutoresizingMaskIntoConstraints = false
        passTf.isSecureTextEntry = true
        
        containerV.backgroundColor = .white
        containerV.layer.cornerRadius = 5
        containerV.layer.masksToBounds = true
        containerV.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerV)
        containerV.addSubview(nameTF)
        containerV.addSubview(nameSeparatorV)
        containerV.addSubview(emailTF)
        containerV.addSubview(emailSeparatorV)
        containerV.addSubview(passTf)
        
        NSLayoutConstraint.activate([
            containerV.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            containerV.topAnchor.constraint(equalTo: view.topAnchor, constant: 350),
            containerV.widthAnchor.constraint(equalToConstant: 350),
            containerV.heightAnchor.constraint(equalToConstant: 150),
            
            nameTF.leftAnchor.constraint(equalTo: containerV.leftAnchor, constant: 10),
            nameTF.topAnchor.constraint(equalTo: containerV.topAnchor),
            nameTF.widthAnchor.constraint(equalTo: containerV.widthAnchor),
            nameTF.heightAnchor.constraint(equalTo: containerV.heightAnchor, multiplier: 1/3),
            
            nameSeparatorV.leftAnchor.constraint(equalTo: containerV.leftAnchor),
            nameSeparatorV.topAnchor.constraint(equalTo: nameTF.bottomAnchor),
            nameSeparatorV.widthAnchor.constraint(equalTo: containerV.widthAnchor),
            nameSeparatorV.heightAnchor.constraint(equalToConstant: 1),
            
            emailTF.leftAnchor.constraint(equalTo: containerV.leftAnchor, constant: 10),
            emailTF.topAnchor.constraint(equalTo: nameTF.bottomAnchor),
            emailTF.widthAnchor.constraint(equalTo: containerV.widthAnchor),
            emailTF.heightAnchor.constraint(equalTo: containerV.heightAnchor, multiplier: 1/3, constant: 0),
            emailSeparatorV.leftAnchor.constraint(equalTo: containerV.leftAnchor),
            emailSeparatorV.topAnchor.constraint(equalTo: emailTF.bottomAnchor),
            emailSeparatorV.widthAnchor.constraint(equalTo: containerV.widthAnchor),
            emailSeparatorV.heightAnchor.constraint(equalToConstant: 1),
            
            passTf.leftAnchor.constraint(equalTo: containerV.leftAnchor, constant: 10),
            passTf.topAnchor.constraint(equalTo: emailTF.bottomAnchor),
            passTf.widthAnchor.constraint(equalTo: containerV.widthAnchor),
            passTf.heightAnchor.constraint(equalTo: containerV.heightAnchor, multiplier: 1/3, constant: 0),
            
        ])
        
        registerBtn.backgroundColor = UIColor(displayP3Red: 70/255, green: 99/255, blue: 160/255, alpha: 1)
        registerBtn.setTitle("Register".localized(), for: .normal)
        registerBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(registerBtn)
        registerBtn.layer.cornerRadius = 10
        registerBtn.addTarget(self, action: #selector(loginRigs), for: .touchUpInside)
        NSLayoutConstraint.activate([
            registerBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            registerBtn.topAnchor.constraint(equalTo: containerV.bottomAnchor, constant: 70),
            registerBtn.widthAnchor.constraint(equalToConstant: 150),
            registerBtn.heightAnchor.constraint(equalToConstant: 50)

        ])
        
        profilImg.image = UIImage(named: "getchat")
        profilImg.layer.cornerRadius = 5
        profilImg.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profilImg)
        NSLayoutConstraint.activate([
            profilImg.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profilImg.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            profilImg.widthAnchor.constraint(equalToConstant: 350),
            profilImg.heightAnchor.constraint(equalToConstant: 250)
        ])
        
        loginRegstSg = UISegmentedControl(items: ["Login".localized(), "Register".localized()])
        loginRegstSg.selectedSegmentIndex = 1
        loginRegstSg.backgroundColor = UIColor(displayP3Red: 75/255, green: 99/255, blue: 170/255, alpha: 1)
        loginRegstSg.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginRegstSg)
        loginRegstSg.addTarget(self, action: #selector(loginRegstSgChg), for:  .valueChanged)
        NSLayoutConstraint.activate([
            loginRegstSg.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginRegstSg.bottomAnchor.constraint(equalTo: containerV.topAnchor, constant: -40),
            loginRegstSg.widthAnchor.constraint(equalTo: containerV.widthAnchor, multiplier: 0.5)
        ])
        
        label.text = "Swift Abha".localized()
        label.textColor = UIColor(displayP3Red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 700),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func loginRigs() {
        if loginRegstSg.selectedSegmentIndex == 0 {
            login()
        }else {
            register()
        }
    }
    
    @objc func register(){
        
        if let email = emailTF.text, email.isEmpty == false,
           let password = passTf.text, password.isEmpty == false {
            
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if error == nil {
                    // go to home vc
                    let vc = UINavigationController(rootViewController: TabBarCustom())
                    vc.modalTransitionStyle = .crossDissolve
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                } else {
                    print(error?.localizedDescription)
                }
                guard let user = result?.user else {return}
                
                self.db.collection("users").document(user.uid).setData([
                    "name": self.nameTF.text,
                    "email": String(user.email!),
                    "userID": user.uid,
                    "status": "yes"
                ], merge: true) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }
            }
        }
    }
    
    func login() {
        if let email = emailTF.text, email.isEmpty == false,
           let password = passTf.text, password.isEmpty == false {
            
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if error == nil {
                    // go to main vc
                    let vc = UINavigationController(rootViewController: TabBarCustom())
                    vc.modalTransitionStyle = .crossDissolve
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                } else {
                    print(error?.localizedDescription)
                }
            }
        }
        
    }
    
    @objc func loginRegstSgChg() {
        let tit = loginRegstSg.titleForSegment(at: loginRegstSg.selectedSegmentIndex)
        registerBtn.setTitle(tit, for: .normal)
    }
}

extension String {
    
    func localized() -> String {
        
        return NSLocalizedString(self,
                                 tableName: "localized",
                                 bundle: .main,
                                 value: self,
                                 comment: self)
    }
}
