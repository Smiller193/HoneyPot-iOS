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
        self.collectionView!.register(ChatListCell.self, forCellWithReuseIdentifier: cellID)

        // Do any additional setup after loading the view.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.chatUsers.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ChatListCell
        cell.chatUser = self.chatUsers[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
