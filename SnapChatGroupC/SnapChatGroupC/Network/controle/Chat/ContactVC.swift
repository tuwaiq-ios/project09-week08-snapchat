//
//  Contact.swift
//  SnapChatGroupC
//
//  Created by sara al zhrani on 07/04/1443 AH.
//
import UIKit
import FirebaseFirestore


class PeopleVC: UIViewController,  UISearchBarDelegate{
    
    let cellId = "PeopleCell"
    var people: [User] = []
    var isSearch:Bool = false{
        didSet {
            peopleTV.reloadData()
        }
    }
    var resultSearch: [User] = []{
        didSet{
            peopleTV.reloadData()
        }
    }
    
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
        searchBar.showsCancelButton = true
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
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearch = true
        print(searchBar.text)
        let seName = (searchBar.text ?? "")
        if people.contains(where: {$0.name == seName}) {
            let result = people.filter({$0.name == seName})
            resultSearch.removeAll()
            resultSearch = result
            print("name is exist")
        } else {
            print ("Not Found")
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearch = false
    }
   
    
}

extension PeopleVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if isSearch {
            return resultSearch.count
        } else {
        return people.count
    }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        let user = people[indexPath.row]
        
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.status
        cell.imageView?.image = UIImage(named: "40")
        
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //2
        let action = UIContextualAction(style: .normal, title: "") { _, _, success in
            let alertController = UIAlertController(title: "Favorite", message: "Add to my Favoiret", preferredStyle: .alert)
            
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: { [self] _ in do {
                let user = people[indexPath.row]
                Firestore.firestore().collection("favorite").document(user.id).setData([
                    "id": user.id,
                    "name": user.name,
                    "status": user.status,
                    "latitude": 0.0,
                    "longitude": 0.0,
                ], merge: true)
            }
                success(true)
            })
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
        action.image = UIImage(systemName: "heart")
        action.backgroundColor = .blue
        
        return UISwipeActionsConfiguration(actions: [action])
    }
}

