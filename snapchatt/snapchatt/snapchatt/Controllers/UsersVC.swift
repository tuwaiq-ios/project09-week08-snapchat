//
//  UsersVC.swift
//  snapchatt
//
//  Created by sally asiri on 08/04/1443 AH.
//

import UIKit
import Firebase
import FirebaseFirestore


class UsersVC : UITableViewController {
    
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Users"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        getUsers()
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Create conversation between me and user
       
        guard let curruntUserId = Auth.auth().currentUser?.uid else { return }
        let otherUser = users[indexPath.row]
        
        Firestore.firestore().collection("users").document(curruntUserId).addSnapshotListener { documnet, error in
            let data = documnet?.data()
            let curruntUserInfo = User(id: curruntUserId,
                                       name: data?["name"] as! String,
                                       status: data!["status"] as! String,
                                       image: data?["image"] as! String,
                                       location: data?["location"] as! String
            )
            
            let filterField = [otherUser.id, curruntUserId].sorted().joined()
            
            let conversation = Conversations(
                id: UUID().uuidString,
                users: [otherUser.id, curruntUserId],
                title: "\(otherUser.name) - \(curruntUserInfo.name)",
                filterField: filterField
            )
            
            Firestore.firestore().collection("conversations")
                .whereField("filterField", isEqualTo: filterField)
                .getDocuments { snapshot, error in
                    if snapshot?.isEmpty ?? true {
                        Firestore.firestore().collection("conversations")
                            .document(conversation.id)
                            .setData([
                                "id": conversation.id,
                                "users": conversation.users,
                                "title":conversation.title,
                                "filterField":conversation.filterField
                            ])
                    }
                }
        }

        
        self.tabBarController?.selectedIndex = 1
//        let vc = ChatVC()
//        vc.user = users[indexPath.row]
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func getUsers() {
        Firestore.firestore().collection("users").addSnapshotListener { snapshot, error in
            if error == nil {
                self.users.removeAll()
                guard let userID = Auth.auth().currentUser?.uid else {return}
                for document in snapshot!.documents{
                    let data = document.data()
                    
                    if data["id"] as? String != userID {
                        self.users.append(User(id: data["id"] as! String,
                                               name: data["name"] as! String,
                                               status: data["status"] as! String,
                                               image: data["image"] as! String,
                                               location: data["location"] as! String ?? "" ))
                    }
                    
                }
                
                self.tableView.reloadData()
                
            } else {
                print("ERROR : ", error?.localizedDescription)
            }
        }
    }
    
}
