//
//  MessagingVC.swift
//  SnapChatGroupC
//
//  Created by sara al zhrani on 07/04/1443 AH.
//

import UIKit
import FirebaseFirestore



class MessageVC:  UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var talking : Array<Conversation> = []

    
    
    
    lazy var conversationTV: UITableView = {
        let t = UITableView()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.delegate = self
        t.dataSource = self
        t.register(UITableViewCell.self, forCellReuseIdentifier: "talkingcell")
        t.backgroundColor = .systemGray6
        return t
    }()

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return talking.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "talkingcell", for: indexPath)
        
        let data = talking[indexPath.row]
      
        cell.textLabel?.text = data.sender
      
        return cell

    }
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(conversationTV)
        NSLayoutConstraint.activate([
            conversationTV.topAnchor.constraint(equalTo: view.topAnchor),
            conversationTV.leftAnchor.constraint(equalTo: view.leftAnchor),
            conversationTV.rightAnchor.constraint(equalTo: view.rightAnchor),
            conversationTV.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        view.backgroundColor = .green
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let talk = talking[indexPath.row]
        
        let navigationController = UINavigationController(
            rootViewController: ChatPageVC()
        )
        navigationController.navigationBar.prefersLargeTitles = true
        
        present(navigationController, animated: true, completion: nil)
    
    }

        
        
    }
    

