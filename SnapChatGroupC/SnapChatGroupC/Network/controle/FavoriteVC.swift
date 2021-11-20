//
//  Favorite.swift
//  SnapChatGroupC
//
//  Created by Abdulaziz on 14/04/1443 AH.
//

import UIKit
import FirebaseFirestore
import Firebase



class FavoriteVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var users = [User]()
    
    var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Firestore.firestore().collection("favorite").addSnapshotListener { snapshot, error in
            if error != nil {
                return
            }
            
            guard let docs = snapshot?.documents else {
                return
            }
            
            var users1: [User] = []
            for doc in docs {
                let data = doc.data()
                guard
                    let id = data["id"] as? String,
                    let name = data["name"] as? String,
                    let status = data["status"] as? String
                        
                else {
                    continue
                }
                
                let latitude = data["latitude"] as? Double
                let longitude = data["longitude"] as? Double
//                let image = data["image"] as? String

                
                let user = User(
                    id: id,
                    name: name,
                    status: status,
                    latitude: latitude ?? 00,
                    longitude: longitude ?? 00
                )
                
                users1.append(user)
                
            }
            
            
            self.users = users1
            
            self.myTableView.reloadData()
            
            
        }
        
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        self.view.addSubview(myTableView)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(users[indexPath.row])")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        let data = users[indexPath.row]
        cell.textLabel?.text = data.name
        cell.detailTextLabel?.text = data.status
        cell.imageView?.image = UIImage(named: "40")
        
        //        cell.textLabel!.text = "\(myArray[indexPath.row])"
        
        return cell
    }
    
}
