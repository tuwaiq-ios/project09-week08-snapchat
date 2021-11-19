//
//  MyProfileVC.swift
//  snapchat_app
//
//  Created by dmdm on 18/11/2021.
//



import UIKit
import FirebaseFirestore
import Firebase


class MyProfileVC : UIViewController, UIImagePickerControllerDelegate, UITextFieldDelegate, UINavigationControllerDelegate{

      lazy var profileImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemCyan
        view.layer.cornerRadius = 25
        view.isUserInteractionEnabled = true
        return view
      }()
    
      lazy var imagePicker : UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        return imagePicker
      }()
    @objc func OpenImage(_ sender: Any) {
       let pick = UIImagePickerController()
       pick.allowsEditing = true
       pick.delegate = self
       present(pick, animated: true)
       }
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       let image = (info[.editedImage] ?? info[.originalImage]) as? UIImage;
         profileImage.image = image
       dismiss(animated: false)
       }

    let name : UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = "Enter Your name"
        $0.backgroundColor = .init(white: 0.85, alpha: 1)
        $0.layer.cornerRadius = 22.5
        $0.textAlignment = .center
        return $0
    }(UITextField())
    let status : UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = "Enter Your Status"
        $0.backgroundColor = .init(white: 0.85, alpha: 1)
        $0.layer.cornerRadius = 22.5
        $0.textAlignment = .center

        return $0
    }(UITextField())
    let Button : UIButton = {
        $0.backgroundColor = .systemCyan
        $0.setTitle("Save", for: .normal)
        $0.tintColor = .systemCyan
        $0.layer.cornerRadius = 22.5
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(haB), for: .touchUpInside)
        return $0
    }(UIButton())
    let Button1 : UIButton = {
        $0.backgroundColor = .white
        $0.setTitle("Sign Out", for: .normal)
        $0.setTitleColor(UIColor.systemCyan, for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(A), for: .touchUpInside)
        return $0
    }(UIButton())
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
             profileImage.addGestureRecognizer(tapRecognizer)
        
        view.backgroundColor = .white
           profileImage.image = .init(systemName: "person.circle")
            profileImage.tintColor = UIColor(ciColor: .black)
            profileImage.layer.masksToBounds = true
            profileImage.layer.cornerRadius = 100
            profileImage.contentMode = .scaleAspectFit
            profileImage.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(profileImage)
            NSLayoutConstraint.activate([
             profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             profileImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
             profileImage.heightAnchor.constraint(equalToConstant: 200),
             profileImage.widthAnchor.constraint(equalToConstant: 200)
            ])
        
                name.font = .boldSystemFont(ofSize: 23)
        name.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(name)
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: view.topAnchor,constant: 440),
            name.leftAnchor.constraint(equalTo: view.leftAnchor , constant: 50),
            name.heightAnchor.constraint(equalToConstant: 40),
            name.widthAnchor.constraint(equalToConstant: 290),
            //name.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: 100)
        ])
        status.textColor = .green
        status.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(status)
        NSLayoutConstraint.activate([
            status.topAnchor.constraint(equalTo: view.topAnchor,constant: 485),
            status.leftAnchor.constraint(equalTo: view.leftAnchor , constant: 50),
            status.heightAnchor.constraint(equalToConstant: 40),
            status.widthAnchor.constraint(equalToConstant: 290),
        ])
        view.addSubview(Button)
        NSLayoutConstraint.activate([
            Button.topAnchor.constraint(equalTo: view.topAnchor,constant: 570),

//            Button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 500),
            Button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            Button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            Button.heightAnchor.constraint(equalToConstant: 70)
        ])
        view.addSubview(Button1)
        NSLayoutConstraint.activate([
            Button1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 570),
            Button1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            Button1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            Button1.heightAnchor.constraint(equalToConstant: 70)
        ])
        guard let currentUserID = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore()
            .document("users/\(currentUserID)")
            .addSnapshotListener{ doucument, error in
                if error != nil {
                    print (error)
                    return
                }
                self.name.text = doucument?.data()?["name"] as? String
                self.status.text = doucument?.data()?["status"] as? String
            }
    }
    @objc func haB() {
        guard let currentUserID = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().document("users/\(currentUserID)").setData([
            "name" : name.text,
            "id" : currentUserID,
            "status" :status.text,
        ])
        let alert1 = UIAlertController(
            title: ("Saved"),
            message: "Saved update data",
            preferredStyle: .alert)
        alert1.addAction(
            UIAlertAction(
                title: "OK",
                style: .default,
                handler: { action in
                    print("OK")
                }
            )
        )
        present(alert1, animated: true, completion: nil)
    }
    @objc func A() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: \(signOutError.localizedDescription)")
        }
    }
    @objc func imageTapped(){
        print("Image Tapped")
        present(imagePicker, animated: true)
    }
       }
