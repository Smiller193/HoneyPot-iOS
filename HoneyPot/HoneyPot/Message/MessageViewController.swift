//
//  MessageViewController.swift
//  HoneyPot
//
//  Created by Shawn Miller on 4/9/18.
//  Copyright © 2018 HoneyPot. All rights reserved.
//

import UIKit
import Firebase


class MessageViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
     private let cellID = "chatCell"
    var chatUsers = [User]()
    var chats = [Chat]()
    
    var userChatsHandle: DatabaseHandle = 0
    var userChatsRef: DatabaseReference?


    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        grabEmployees()
        setupViews()
        grabChats()
        self.collectionView!.register(ChatListCell.self, forCellWithReuseIdentifier: cellID)

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    @objc func grabEmployees(){
        UserService.following { (users) in
            self.chatUsers = users
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
    
    @objc func grabChats(){
        userChatsHandle = UserService.observeChats { [weak self] (ref, chats) in
            self?.userChatsRef = ref
            self?.chats = chats
            
            // 3
            DispatchQueue.main.async {
                self?.collectionView?.reloadData()
            }
        }
    }
    
    deinit {
        // 4
        userChatsRef?.removeObserver(withHandle: userChatsHandle)
    }
    
    @objc func setupViews(){
        navigationItem.title = "Messages"
        collectionView?.backgroundColor = .white
        collectionView?.alwaysBounceVertical = true
        let addButton = UIBarButtonItem(image: UIImage(named: "icons8-plus-math-48"), style: .plain, target: self, action: #selector(presentNewChat))
        self.navigationItem.rightBarButtonItem = addButton

    }
    
    @objc fileprivate func presentNewChat(){
        let newChatVC = NewChatViewController(collectionViewLayout: UICollectionViewFlowLayout())
        self.navigationController?.pushViewController(newChatVC, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return chats.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ChatListCell
        let chat = chats[indexPath.item]
        UserService.show(forUID: chat.memberUIDs[1]) { (user) in
            print(chat.memberUIDs[1])
            print(user?.username)
            cell.chatUser = user
        }
        cell.timeLabel.text = timeStringFromUnixTime(unixTime: (chat.lastMessageSent?.timeIntervalSince1970)!)
        cell.messageLabel.text = chat.lastMessage
        return cell
    }
    
    func timeStringFromUnixTime(unixTime: Double) -> String {
        let date = NSDate(timeIntervalSince1970: unixTime)
        let dateFormatter = DateFormatter()
        // Returns date formatted as 12 hour time.
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date as Date)
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let chatVC = ChatViewController()
        chatVC.chat = chats[indexPath.item]
        self.navigationController?.pushViewController(chatVC, animated: true)
        
    }


}
