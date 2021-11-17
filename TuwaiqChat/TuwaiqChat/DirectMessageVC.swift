//
//  DirectMessageVC.swift
//  TuwaiqChat
//
//  Created by PC on 09/04/1443 AH.
//

import UIKit
import Firebase

class DirectMessageVC : UIViewController {
    
    var user : User?
    var bottomViewConstraint = NSLayoutConstraint()
    var bottomPadding : CGFloat = 0
    
    var messages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllMessages()
        keyboardSetting()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        navigationItem.title = user?.name
        setGradientBackground()
        
        view.addSubview(messagesTableView)
        view.addSubview(bottomView)
        bottomView.addSubview(messageView)
        bottomView.addSubview(sendButton)
        
        NSLayoutConstraint.activate([
            messagesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            messagesTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            messagesTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            bottomView.topAnchor.constraint(equalTo: messagesTableView.bottomAnchor),
            bottomView.leftAnchor.constraint(equalTo: view.leftAnchor),
            bottomView.rightAnchor.constraint(equalTo: view.rightAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 50),
            
            messageView.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 5),
            messageView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -5),
            messageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            messageView.rightAnchor.constraint(equalTo: sendButton.leftAnchor, constant: -10),
            
            sendButton.centerYAnchor.constraint(equalTo: messageView.centerYAnchor),
            sendButton.rightAnchor.constraint(equalTo: bottomView.rightAnchor, constant: -10),
            sendButton.heightAnchor.constraint(equalToConstant: 40),
            sendButton.widthAnchor.constraint(equalTo: sendButton.heightAnchor),
            
        ])
        
        bottomViewConstraint = bottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        bottomViewConstraint.isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    
    lazy var messagesTableView : UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.delegate = self
        $0.dataSource = self
        $0.register(MessageCell.self, forCellReuseIdentifier: "Cell")
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        return $0
    }(UITableView())
    
    
    let bottomView : UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(red: 0.17, green: 0.32, blue: 0.36, alpha: 1.00)
        return $0
    }(UIView())
        
    
    let sendButton : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setBackgroundImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        $0.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
    
    let messageView : CustomTextFieldView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textField.placeholder = "Message here"
        $0.textField.textAlignment = .left
        return $0
    }(CustomTextFieldView())
    
}


extension DirectMessageVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messagesTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MessageCell
        
        let currentUserID = Auth.auth().currentUser?.uid
        
        if messages[indexPath.row].sender == currentUserID {
            cell.MainViewTrailingAnchor.isActive = true
            cell.MainViewLeadingAnchor.isActive = false
            cell.bubbleImage.tintColor = .init(white: 0.90, alpha: 0.5)
            cell.bubbleImage.image = UIImage(named: "ChatBubble_rt")
            cell.messageLabel.textColor = .black
        } else {
            cell.MainViewTrailingAnchor.isActive = false
            cell.MainViewLeadingAnchor.isActive = true
            cell.bubbleImage.tintColor = UIColor(red: 0.17, green: 0.32, blue: 0.36, alpha: 1.00)
            cell.bubbleImage.image = UIImage(named: "ChatBubble_lt")
            cell.messageLabel.textColor = .white
        }
        
        cell.messageLabel.text = messages[indexPath.row].content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
    }
    
}


extension DirectMessageVC {
    @objc func sendMessage() {
        let messageId = String(Date().timeIntervalSince1970)
        guard let currentUserID = Auth.auth().currentUser?.uid else {return}
        guard let message = messageView.textField.text else {return}
        guard let user = user else {return}
        Firestore.firestore().document("Messages/\(messageId)").setData([
            "sender" : currentUserID,
            "reciever" : user.id!,
            "message" : message
        ])
        
        messageView.textField.text = ""
    }
    
    func getAllMessages() {
        Firestore.firestore().collection("Messages").addSnapshotListener { [self] snapshot, error in
            self.messages.removeAll()
            guard let currentUserID = Auth.auth().currentUser?.uid else {return}
            if error == nil {
                for document in snapshot!.documents{
                    let data = document.data()
                    if let sender = data["sender"] as? String, let reciever = data["reciever"] as? String {
                        if (sender == currentUserID && reciever == user?.id) || (sender == user?.id && reciever == currentUserID) {
                            self.messages.append(Message(content: data["message"] as? String, sender: sender , reciever: reciever))
                        }
                    }
                }
                self.messagesTableView.reloadData()
                self.messagesTableView.scrollToBottomRow()
            }
        }
    }
    
}



extension DirectMessageVC {
    
    func keyboardSetting() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func handleKeyboardNotification(notification : NSNotification) {
        if let userInfo = notification.userInfo {
            
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            
            bottomViewConstraint.constant = isKeyboardShowing ? -(keyboardFrame!.height) + bottomPadding : 0
            
            UIView.animate(withDuration: 0, delay: 0, options: .curveEaseInOut, animations: {
                self.view.layoutIfNeeded()
                print(self.bottomViewConstraint.constant)
            }) { (completed) in
                self.messagesTableView.scrollToBottomRow()
                
                
            }
        }
    }
}
