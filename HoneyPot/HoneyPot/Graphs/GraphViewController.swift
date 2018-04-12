//
//  GraphViewController.swift
//  HoneyPot
//
//  Created by Shawn Miller on 3/26/18.
//  Copyright © 2018 HoneyPot. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Attack Graphs"
        view.addSubview(logoImageView)
        view.addSubview(logoImageView2)
        logoImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        logoImageView2.anchor(top: logoImageView.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    public var logoImageView: UIImageView = {
        let firstImage = UIImageView()
        firstImage.clipsToBounds = true
        firstImage.image = UIImage(named: "groupedbarchart")?.withRenderingMode(.alwaysOriginal)
        firstImage.translatesAutoresizingMaskIntoConstraints = false
        firstImage.contentMode = .scaleAspectFit
        return firstImage
    }()
    
    
    public var logoImageView2: UIImageView = {
        let firstImage = UIImageView()
        firstImage.clipsToBounds = true
        firstImage.image = UIImage(named: "images")?.withRenderingMode(.alwaysOriginal)
        firstImage.translatesAutoresizingMaskIntoConstraints = false
        firstImage.contentMode = .scaleAspectFit
        return firstImage
    }()
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
