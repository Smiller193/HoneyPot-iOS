//
//  NewChatViewController.swift
//  HoneyPot
//
//  Created by Shawn Miller on 4/11/18.
//  Copyright © 2018 HoneyPot. All rights reserved.
//

import UIKit


class NewChatViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    private let cellID = "cellID"
    var coworkers = [User]()
    var selectedUser: User?
    var existingChat: Chat?
    //bar button items
    lazy var nextButton = UIBarButtonItem(image: UIImage(named: "icons8-forward-filled-50"), style: .plain, target: self, action: #selector(nextButtonTapped))
    lazy var backButton = UIBarButtonItem(image: UIImage(named: "icons8-back-filled-50"), style: .plain, target: self, action: #selector(GoBack))
    override func viewDidLoad() {
        super.viewDidLoad()
        grabEmployees()
        setupViews()
        // Do any additional setup after loading the view.
    }

    
   @objc func setupViews(){
    nextButton.isEnabled = false
    self.collectionView?.backgroundColor = .white
    navigationItem.title = "New Message"
    collectionView?.alwaysBounceVertical = true
    self.collectionView!.register(employeeCell.self, forCellWithReuseIdentifier: cellID)
    
    self.navigationItem.leftBarButtonItem = backButton
    
    self.navigationItem.rightBarButtonItem = nextButton
    }
    @objc func nextButtonTapped(_ sender: UIBarButtonItem){
        print("NEXT TAPPED")
        sender.isEnabled = false
        guard let selectedUser = selectedUser else { return }
        ChatService.checkForExistingChat(with: selectedUser) { (chat) in
            sender.isEnabled = true
            self.existingChat = chat
            let members = [selectedUser, User.current]
            let chatVC = ChatViewController()
            chatVC.chat = self.existingChat ?? Chat(members: members)
            self.navigationController?.pushViewController(chatVC, animated: true)
        }
        
        

    }
    @objc func GoBack(){
        print("BACK TAPPED")
        self.navigationController?.popViewController(animated: true)
    }
    @objc func grabEmployees(){
        UserService.following { (users) in
            self.coworkers = users
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

 


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return coworkers.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! employeeCell
        cell.coworker = self.coworkers[indexPath.item]
        if let selectedUser = selectedUser, selectedUser.uid == coworkers[indexPath.item].uid {
            cell.isSelected = true
        } else {
            cell.isSelected = false
        }
        // Configure the cell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 75)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = UIColor.gray.cgColor
        // 2
        selectedUser = coworkers[indexPath.item]
        cell.isSelected = true
        nextButton.isEnabled = true

    }

    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        cell.layer.borderWidth = 0.0
        cell.layer.borderColor = UIColor.clear.cgColor
        cell.isSelected = false
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
