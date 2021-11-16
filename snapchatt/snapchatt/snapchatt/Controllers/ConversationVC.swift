//
//  conversationVC.swift
//  snapchatt
//
//  Created by Tsnim Alqahtani on 11/04/1443 AH.
//


import UIKit
import FirebaseFirestore
import Firebase

class ConversationVC: UIViewController , UITableViewDataSource, UITableViewDelegate {
    
    var conversation: Array<Conversations> = []
    let TVC = UITableView()
        
    
//    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TVC.translatesAutoresizingMaskIntoConstraints = false
        TVC.dataSource = self
        TVC.delegate = self
        view.backgroundColor = .white
        navigationItem.title = "Users"
        
        view.addSubview(TVC)
        //constraint
        NSLayoutConstraint.activate([
    
        TVC.leftAnchor.constraint (equalTo: view.leftAnchor),
        TVC.rightAnchor.constraint(equalTo: view.rightAnchor),
        TVC.topAnchor.constraint(equalTo: view.topAnchor),
        TVC.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                                    ])
        TVC.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
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
        // Create conversation between me and user
        self.tabBarController?.selectedIndex = 1
//         let navigation = UINavigationController()
//         present(UINavigationController(rootViewController: ConversationVC),
//                     animated: true,
//                     completion: nil
//                 )
//
//        let vc = ChatVC()
//        vc.user = users[indexPath.row]
//        navigationController?.pushViewController(vc, animated: true)
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
                
                self.TVC.reloadData()
                
            } else {
                print("ERROR : ", error?.localizedDescription)
            }
        }
    }
    
}
