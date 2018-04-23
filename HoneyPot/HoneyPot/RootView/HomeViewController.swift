//
//  HomeViewController.swift
//  HoneyPot
//
//  Created by Shawn Miller on 3/26/18.
//  Copyright © 2018 HoneyPot. All rights reserved.
//

import UIKit
import  SVProgressHUD

class HomeViewController: UITabBarController {
    
    
    lazy var viewControllerList: [UIViewController] = {
        let graph = GraphViewController()
        let graphNavController = UINavigationController(rootViewController: graph)
        graphNavController.tabBarItem.image = UIImage(named: "icons8-home-page-50 (1)")?.withRenderingMode(.alwaysOriginal)
        graphNavController.tabBarItem.selectedImage = UIImage(named: "iicons8-home-page-filled-50 (1)")?.withRenderingMode(.alwaysOriginal)
        graphNavController.tabBarItem.title = "Home"

        //        let navController = ScrollingNavigationController(rootViewController: homeFeedController)
        
        
        let profileView = ProfileViewController()
        let profileViewNavController = UINavigationController(rootViewController: profileView)
        profileViewNavController.tabBarItem.image = UIImage(named: "icons8-user-50")?.withRenderingMode(.alwaysOriginal)
        profileViewNavController.tabBarItem.selectedImage = UIImage(named: "icons8-user-filled-50")?.withRenderingMode(.alwaysOriginal)
        profileViewNavController.tabBarItem.title = "Profile"

        
        
        let messages = MessageViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let messagesNavController = UINavigationController(rootViewController: messages)
        
        messagesNavController.tabBarItem.image =  UIImage(named: "icons8-new-post-50")?.withRenderingMode(.alwaysOriginal)
        messagesNavController.tabBarItem.selectedImage =  UIImage(named: "icons8-new-post-filled-50")?.withRenderingMode(.alwaysOriginal)
        messagesNavController.tabBarItem.title = "Chats"


        
        return [graphNavController,messagesNavController]
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.dismiss()
        
        viewControllers = viewControllerList
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 250, green: 191, blue: 18)], for:.normal)
        
        guard let items = tabBar.items else {
            return
        }
        for item in items{
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
