//
//  GraphWebView.swift
//  HoneyPot
//
//  Created by Shawn Miller on 4/30/18.
//  Copyright © 2018 HoneyPot. All rights reserved.
//

import Foundation
import UIKit

class GraphWebViewController: UIViewController {
    let webView = UIWebView()
     lazy var backButton = UIBarButtonItem(image: UIImage(named: "icons8-back-filled-50"), style: .plain, target: self, action: #selector(GoBack))
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVc()
        // Do any additional setup after loading the view.
    }
    
    @objc func setupVc(){
        view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        self.webView.scalesPageToFit = true
        webView.loadRequest(URLRequest(url: URL(string: "http://ec2-18-218-88-192.us-east-2.compute.amazonaws.com:8080/ActiveHoneypotWeb/graphs.html")! ))
         self.navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func GoBack(){
        print("BACK TAPPED")
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
}
