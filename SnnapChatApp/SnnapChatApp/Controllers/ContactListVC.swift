//
//  ContactListVC.swift
//  SnnapChatApp
//
//  Created by dmdm on 15/11/2021.
//

import UIKit

class ContactListVC: UIViewController {
    
    let cellId = "ContactCell"
    var people: [User] = []
    
    lazy var ContactTV: UITableView = {
        let tv = UITableView()
        tv.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Contectact"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        UsersService.shared.listenToUsers { newUsers in
            self.people = newUsers
            self.ContactTV.reloadData()
        }
        
        
        view.addSubview(ContactTV)
        NSLayoutConstraint.activate([
            ContactTV.topAnchor.constraint(equalTo: view.topAnchor),
            ContactTV.rightAnchor.constraint(equalTo: view.rightAnchor),
            ContactTV.leftAnchor.constraint(equalTo: view.leftAnchor),
            ContactTV.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
}
extension ContactListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        let user = people[indexPath.row]
        
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.status
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = people[indexPath.row]
        let messagingVC = ChatVC()
        messagingVC.user = user
        messagingVC.title = user.name
        
        present(
            UINavigationController(rootViewController: messagingVC),
            animated: true,
            completion: nil
        )
    }
}
