//
//  MainVC.swift
//  TuwaiqChat
//
//  Created by PC on 08/04/1443 AH.
//

import UIKit
import Firebase
import SDWebImage

class MainVC : UIViewController {
    
    var users = [User]()
    var filteredUsers = [User]()
    
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getAllUsers()
        
        let profileButton = UIBarButtonItem(image: UIImage(systemName: "person.circle.fill"), style: .plain, target: self, action: #selector(showProfile))
        navigationItem.rightBarButtonItem = profileButton
    }
   
    
    @objc func showProfile() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.pushViewController(UserProfileVC(), animated: true)
    }
    
    lazy var searchBar : UISearchBar = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = "search..."
        $0.delegate = self
        return $0
    }(UISearchBar())
    
    
    lazy var usersTableView : UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.delegate = self
        $0.dataSource = self
        $0.register(CustomCell.self, forCellReuseIdentifier: "Cell")
        $0.backgroundColor = .clear
        return $0
    }(UITableView())
    
    
    func getAllUsers() {
        Firestore.firestore().collection("Users").addSnapshotListener { snapshot, error in
            self.users.removeAll()
            if error == nil {
                if let value = snapshot?.documents {
                    for user in value {
                        let userData = user.data()
                        
                        guard let currentUserID = Auth.auth().currentUser?.uid else {return}
                        if userData["id"] as? String != currentUserID {
                            self.users.append(User(id: userData["id"] as? String, name: userData["name"] as? String, email: userData["email"] as? String, profileImage: userData["profileImage"] as? String, lat: userData["userLatitude"] as? Double, long: userData["userLongtude"] as? Double))
                        }
                            
                    }
                }
                self.usersTableView.reloadData()
            }
        }
    }
}


extension MainVC {
    func setupUI () {
        
        navigationItem.title = "Contacts"
        setGradientBackground()
        
        view.addSubview(searchBar)
        view.addSubview(usersTableView)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchBar.heightAnchor.constraint(equalToConstant: 40),
            
            usersTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 5),
            usersTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            usersTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usersTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}


extension MainVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredUsers.count
        } else {
            return users.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = usersTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell
        
//        cell.userImage.image = nil
        if isSearching {
            cell.nameLabel.text = filteredUsers[indexPath.row].name

            if let imageURL = filteredUsers[indexPath.row].profileImage {
                cell.userImage.sd_setImage(with: URL(string: imageURL), completed: nil)
            } else {
                cell.userImage.image = UIImage(systemName: "person.circle.fill")
            }
        } else {
            cell.nameLabel.text = users[indexPath.row].name

            if let imageURL = users[indexPath.row].profileImage {
                cell.userImage.sd_setImage(with: URL(string: imageURL), completed: nil)
            }
            else {
                cell.userImage.image = UIImage(systemName: "person.circle.fill")
            }
        }
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        view.endEditing(true)
        let vc = DirectMessageVC()
        
        if isSearching {
            vc.user = filteredUsers[indexPath.row]
        } else {
            vc.user = users[indexPath.row]
        }
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension MainVC : UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearching = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredUsers.removeAll()
        if searchText == "" {
            isSearching = false
            self.usersTableView.reloadData()
        }
        else {
            isSearching = true
            filteredUsers = users.filter({ user in
                return user.name!.lowercased().contains(searchText.lowercased())
            })
            self.usersTableView.reloadData()
        }
    }
}
