//
//  MessagingVC.swift
//  SnapChat
//
//  Created by Amal on 11/04/1443 AH.
//


import UIKit
import FirebaseFirestore
import Firebase

class ConversationVC: UIViewController , UITableViewDataSource, UITableViewDelegate {
    
    var conversation: Array<Conversations> = []
    
    lazy var ConversationTV : UITableView = {
        let ConversationTV = UITableView()
        ConversationTV.translatesAutoresizingMaskIntoConstraints = false
        ConversationTV.dataSource = self
        ConversationTV.delegate = self
        return ConversationTV
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor (named: "myBackgroundColor")
        
        view.addSubview(ConversationTV)
        //constraint tabel view
        NSLayoutConstraint.activate([
            ConversationTV.leftAnchor.constraint (equalTo: view.leftAnchor),
            ConversationTV.rightAnchor.constraint(equalTo: view.rightAnchor),
            ConversationTV.topAnchor.constraint(equalTo: view.topAnchor),
            ConversationTV.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        ConversationTV.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        getConversation()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        print(conversation[indexPath.row].title)
        cell.textLabel?.text = conversation[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Create conversation between me and user
        self.tabBarController?.selectedIndex = 1
        let messagingVC = ChatVC()
        messagingVC.conversation = conversation[indexPath.row]
        messagingVC.title = conversation[indexPath.row].title
        navigationController?.pushViewController(messagingVC, animated: true)
        
    }
    
    
    func getConversation() {
        guard let userID = Auth.auth().currentUser?.uid else {return}
        
        Firestore.firestore().collection("conversations")
            .whereField("users", arrayContains: userID)
            .addSnapshotListener { snapshot, error in
                if error == nil {
                    self.conversation.removeAll()
                    
                    for document in snapshot!.documents {
                        let data = document.data()
                        
                        
                        self.conversation.append(Conversations(
                            id: (data["id"] as! String) ,
                            users: data["users"] as! [String],
                            title: data["title"] as! String,
                            filterField: data["filterField"] as! String
                        ))
                        
                    }
                    self.ConversationTV.reloadData()
                    
                } else {
                    print("ERROR : ", error?.localizedDescription)
                }
            }
    }
    
}
