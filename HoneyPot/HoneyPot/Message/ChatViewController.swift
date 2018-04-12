//
//  ChatViewController.swift
//  HoneyPot
//
//  Created by Shawn Miller on 4/11/18.
//  Copyright © 2018 HoneyPot. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    var chat: Chat!
 lazy var dismissButton = UIBarButtonItem(image: UIImage(named: "icons8-delete-filled-50"), style: .plain, target: self, action: #selector(GoBack))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        // Do any additional setup after loading the view.
    }
    @objc func setupViews(){
        self.navigationItem.leftBarButtonItem = dismissButton
        view.backgroundColor = .red
    }
    @objc func GoBack(){
        print("BACK TAPPED")
        self.navigationController?.popViewController(animated: true)
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
