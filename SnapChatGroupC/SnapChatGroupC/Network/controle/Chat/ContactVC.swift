//
//  Contact.swift
//  SnapChatGroupC
//
//  Created by sara al zhrani on 07/04/1443 AH.
//
import UIKit


class PeopleVC: UIViewController,  UISearchBarDelegate{
    
    let cellId = "PeopleCell"
    var people: [User] = []
    
    lazy var searchBar:UISearchBar = UISearchBar()
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
        
        UsersService.shared.listenToUsers { newUsers in
            self.people = newUsers
            self.peopleTV.reloadData()
        }
        
        searchBar.searchBarStyle = UISearchBar.Style.default
       searchBar.placeholder = " Search..."
       searchBar.sizeToFit()
       searchBar.isTranslucent = false
       searchBar.backgroundImage = UIImage()
       searchBar.delegate = self
       navigationItem.titleView = searchBar
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
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String)
    {
        
    }
    
}

extension PeopleVC: UITableViewDelegate, UITableViewDataSource {
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
        let messagingVC = ChatPageVC()
        messagingVC.user = user
        messagingVC.title = user.name
        
        present(
            UINavigationController(rootViewController: messagingVC),
            animated: true,
            completion: nil
        )
    }
}

