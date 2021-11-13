//
//  NewConversationViewController.swift
//  Snapchat
//
//  Created by Fno Khalid on 08/04/1443 AH.
//

import UIKit


class NewConversationViewController: UIViewController {
    
    let tableView = UITableView()
    var forwardDelegate: ChatViewController!
    var conversationDelegate: ConversationsViewController!
    var forwardName: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .purple
        setupTableView()
        
        
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(NewConversationCell.self, forCellReuseIdentifier: "NewConversationCell")
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
 
}
