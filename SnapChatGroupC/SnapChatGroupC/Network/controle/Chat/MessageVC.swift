//
//  MessagingVC.swift
//  SnapChatGroupC
//
//  Created by sara al zhrani on 07/04/1443 AH.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth



class MessageVC:  UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var talking : Array<Conversation> = []
    {
        didSet {
            conversationTV.reloadData()
        }
    }
    var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.tintColor = .white
        spinner.backgroundColor = .gray
        return spinner
    }()
    
    var people: [User] = []
    lazy var conversationTV: UITableView = {
        let t = UITableView()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.delegate = self
        t.dataSource = self
        t.register(UITableViewCell.self, forCellReuseIdentifier: "talkingcell")
        t.backgroundColor = .systemGray6
        return t
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(conversationTV)
        view.addSubview(spinner)
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.heightAnchor.constraint(equalToConstant: view.bounds.height).isActive = true
        spinner.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        NSLayoutConstraint.activate([
            conversationTV.topAnchor.constraint(equalTo: view.topAnchor),
            conversationTV.leftAnchor.constraint(equalTo: view.leftAnchor),
            conversationTV.rightAnchor.constraint(equalTo: view.rightAnchor),
            conversationTV.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        view.backgroundColor = .green
        spinner.startAnimating()
        guard  let user = Auth.auth().currentUser else { return }
        MessagesService.shared.getAllConversation { conversation in
            print(conversation)
            self.talking = conversation
            let time = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: time, execute: {
                self.spinner.stopAnimating()
            })
          
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return talking.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "talkingcell", for: indexPath)
        let data = talking[indexPath.row]
        cell.imageView?.image = UIImage(named: "40")
        cell.textLabel?.text = (data.usersIds.first ?? "no name") + " - " +  (data.usersIds.last ?? "no name")
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let talk = talking[indexPath.row]
        var account: [User] = []
        Firestore.firestore().collection("users").getDocuments(completion: { sanpShot, error in
                    guard  error == nil else {return}
                    guard let users = sanpShot?.documents else { return }
                    for user in users {
                      let user = user.data()
                            let id = user["id"] as? String ?? ""
                            let name = user["name"] as? String ?? ""
                         let status = user["status"] as? String ?? ""
                        let image = user["image"] as? String ?? ""
                        let latitude = user["latitude"] as? Double ?? 0
                        let longitude = user["longitude"] as? Double ?? 0
                        let curUser = User(id: id, name: name, status: status, latitude: latitude, longitude: longitude)
                        account.append(curUser)

                }
            let view = ChatPageVC()
            let userAccount = account.first(where: {$0.id == talk.reciverId})
            view.user = userAccount
            self.present(UINavigationController(rootViewController:view), animated: true, completion: nil)
        
                })
             
    }
}


