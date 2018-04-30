//
//  MapViewController.swift
//  HoneyPot
//
//  Created by Shawn Miller on 4/29/18.
//  Copyright © 2018 HoneyPot. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController,MKMapViewDelegate {
    var mapView: MKMapView = MKMapView()
    var selectedAnnotation: PinAnnotation?
    var urlContents = ""
    var navTitle = ""

    lazy var backButton = UIBarButtonItem(image: UIImage(named: "icons8-back-filled-50"), style: .plain, target: self, action: #selector(GoBack))

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()

        // Do any additional setup after loading the view.
    }

    @objc func setupVC(){
        mapView.delegate = self
        view.addSubview(mapView)
        self.navigationItem.leftBarButtonItem = backButton
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.title = "Attacks"
        mapView.snp.makeConstraints({ (make) in
            make.edges.equalTo(view)
        })
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let selectedAnno = view.annotation as? PinAnnotation else {
            return
        }
        print("annotation selected")
        self.selectedAnnotation = selectedAnno
        guard let logFileText = selectedAnnotation?.logFile else {
            return
        }
        print(logFileText)
        let urlString = "http://18.218.88.192:8080/ActiveHoneypotWeb/logfiles/\(logFileText)"
        self.navTitle = logFileText

        grabTextFile(urlString: urlString, navTitle: self.navTitle)
    }
    
    
    
    
    @objc func grabTextFile(urlString: String, navTitle: String){
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        
        if let messageURL = URL(string: urlString) {
            let sharedSession = URLSession.shared
            let downloadTask = sharedSession.downloadTask(with: messageURL) { (location, response, error) in
                if let location = location {
                    do{
                        self.urlContents = try String(contentsOf: location, encoding: String.Encoding.utf8)
                        dispatchGroup.leave()
                    }catch {
                        print("Couldn't load string from \(location)")
                    }
                } else if let error = error {
                    print("Unable to load data: \(error)")
                }
            }
            downloadTask.resume()
        } else {
            print("\(urlString) isn't a valid URL")
        }
        
        dispatchGroup.notify(queue: .main) {
            print(self.urlContents)
            self.presentVc(navTitle: self.navTitle, urlContents: self.urlContents)
        }
        
    }
    
    
    @objc func presentVc(navTitle: String, urlContents: String){
        let logFileVC = LogFileViewController()
        print(urlContents)
        logFileVC.navigationItem.title = navTitle
        logFileVC.textView.text = urlContents
        print(self.urlContents)
        self.navigationController?.pushViewController(logFileVC, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func GoBack(){
        print("BACK TAPPED")
        self.navigationController?.popViewController(animated: true)
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
