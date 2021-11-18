//
//  UserVC.swift
//  SnapChat
//
//  Created by Fawaz on 04/04/1443 AH.
//

import UIKit
class UsersVC: UIViewController {
    
    let cellId = "PeopleCell"
    var people: [User] = []
    
    lazy var peopleTV: UITableView = {
        let tv = UITableView()
        tv.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RegisterService.shared.listenToUsers { newUsers in
            self.people = newUsers
            self.peopleTV.reloadData()
        }
        
        view.backgroundColor = .brown
        let image = UIImage(systemName: "chat")
        tabBarItem = .init(title: "People", image: image, selectedImage: image)
        
        view.addSubview(peopleTV)
        NSLayoutConstraint.activate([
            peopleTV.topAnchor.constraint(equalTo: view.topAnchor),
            peopleTV.rightAnchor.constraint(equalTo: view.rightAnchor),
            peopleTV.leftAnchor.constraint(equalTo: view.leftAnchor),
            peopleTV.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
}

extension UsersVC: UITableViewDelegate, UITableViewDataSource {
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
        let messagingVC = ConversationVC()
        messagingVC.users = user
        messagingVC.title = user.name
        messagingVC.modalPresentationStyle = .fullScreen
        present(
            UINavigationController(rootViewController: messagingVC),
            animated: true,
            completion: nil
        )
    }
}
