//
//  LogFileViewController.swift
//  HoneyPot
//
//  Created by Shawn Miller on 4/27/18.
//  Copyright © 2018 HoneyPot. All rights reserved.
//

import UIKit

class LogFileViewController: UIViewController {
    let textView : UITextView  = {
        let textView = UITextView()
        textView.isUserInteractionEnabled = false
        textView.backgroundColor = .clear
        textView.font = UIFont(name: "Helvetica-Bold", size: 15)
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVc()
        // Do any additional setup after loading the view.
    }
    @objc func setupVc() {
          var backButton = UIBarButtonItem(image: UIImage(named: "icons8-back-filled-50"), style: .plain, target: self, action: #selector(GoBack))
        self.navigationItem.leftBarButtonItem = backButton
        view.addSubview(textView)
        textView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    @objc func GoBack(){
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
