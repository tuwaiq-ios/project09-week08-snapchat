//
//  CoversationViewController.swift
//  Snapchat
//
//  Created by Eth Os on 08/04/1443 AH.
//

import UIKit

class ConversationsViewController: UIViewController {
    
    let convNetworking = ConversationsNetworking()
    var messages = [Messages]()
    let tableView = UITableView()
    let calender = Calendar(identifier: .islamic)
    var newConversationButton = UIBarButtonItem()
    var tabBarBadge: UIBarButtonItem!
//    let blankLoadingView = AnimationView(animation: Animation.named("blankLoadingAnim"))
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Chats"
        view.backgroundColor = .systemGray6
        if let tabItems = tabBarController?.tabBar.items {
            tabBarBadge = tabItems[1]
        }
        
        setupTableView()
        setupNewConversationButton()
        newConversationTapped()
       

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(ConversationsCell.self, forCellReuseIdentifier: "ConversationsCell")
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupNewConversationButton() {
        newConversationButton = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(newConversationTapped))
        newConversationButton.tintColor = .black
        navigationItem.rightBarButtonItem = newConversationButton
    }
    
    @objc func newConversationTapped() {
        let controller = NewConversationViewController()
        controller.conversationDelegate = self
        present(UINavigationController(rootViewController: controller), animated: true, completion: nil)
    }

//    func observeIsUserTypingHandler(_ recent: Messages, _ cell: ConversationsCell){
//        convNetworking.observeIsUserTyping(recent.determineUser()) { (isTyping, friendId) in
//            if isTyping && cell.message?.determineUser() == friendId {
//                cell.recentMessage.isHidden = true
//                cell.timeLabel.isHidden = true
//                cell.isTypingView.isHidden = false
//                cell.checkmark.isHidden = true
//            }else{
//                self.setupNoTypingCell(cell)
//                if cell.message?.sender == CurrentUser.uid{
//                    cell.checkmark.isHidden = false
//                }
//            }
//        }
//    }
}
