//
//  GraphViewController.swift
//  HoneyPot
//
//  Created by Shawn Miller on 3/26/18.
//  Copyright © 2018 HoneyPot. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireNetworkActivityIndicator
import SwiftyJSON
import Firebase
import MapKit
import SVProgressHUD

class GraphViewController: UITableViewController {
    var cellID = "cellID"
    let dispatchGroup = DispatchGroup()
    let mapVC = MapViewController()
    let graphWebVc = GraphWebViewController()
    var pin: PinAnnotation?
    var Attacks = [AttackArray]()
    var pinArray = [PinAnnotation]()
    var attackRef: DatabaseReference?
    var attackHandle: DatabaseHandle = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        // Do any additional setup after loading the view.
    }
    var isFinishedPaging: Bool = false
    
    @objc func setupVC(){
        navigationItem.title = "Home"
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.register(AttackTableViewCell.self, forCellReuseIdentifier: cellID)
        let mapButton = UIBarButtonItem(image: UIImage(named: "icons8-map-48"), style: .plain, target: self, action: #selector(presentMap))
        self.navigationItem.leftBarButtonItem = mapButton
        let graphButton = UIBarButtonItem(image: UIImage(named: "icons8-combo-chart-50"), style: .plain, target: self, action: #selector(presentGraphs))
        self.navigationItem.rightBarButtonItem = graphButton
        observeAttacks()
        paginatePost()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }

    
    @objc func presentMap(){
        print("Button pressed")
        self.navigationController?.pushViewController(mapVC, animated: true)
    }
    
    @objc func presentGraphs(){
        print("presenting graphs")
        self.navigationController?.pushViewController(graphWebVc, animated: true)
        
    }
    
    @objc func observeAttacks(){
       attackHandle = AtackService.observeAttacks { (ref, Attack) in
        if let long = Attack?.longitude, let lat = Attack?.latitude {
            self.pin = PinAnnotation(title: "Alert", subtitle: "Attack Detected From This Location", coordinate: CLLocationCoordinate2DMake(Double(lat)!, Double(long)!), logFile: (Attack?.logFile)!)
            self.mapVC.mapView.addAnnotation(self.pin!)
        }
        self.attackRef = ref
        let AttacksArray = AttackArray(attackNumber: (Attack?.key)!, attack: Attack!)
        self.Attacks.append(AttacksArray)
        self.tableView.reloadData()
        }

        
    }
    @objc func paginatePost(){
        AtackService.fetchUserAttack(for: "", currentAttackCount: 0, isFinishedPaging: isFinishedPaging) { (Attack, pagingResult) in
            self.dispatchGroup.enter()
            _ = AttackArray(attackNumber: Attack.key!, attack: Attack)
            self.dispatchGroup.leave()
            self.isFinishedPaging = pagingResult
        }
        
        dispatchGroup.notify(queue: .main) {
            // dismiss the revealing view
            self.tableView.reloadData()
            NotificationCenter.default.post(name: heartAttackNotificationName, object: nil)
        }
    }
    
    @objc func paginatePostWithKey(lastKey: String, attackCount: Int, isFinishedPaging: Bool){
        AtackService.fetchUserAttack(for: lastKey, currentAttackCount: attackCount, isFinishedPaging: isFinishedPaging) { (Attack, pagingResult) in
            print("tried it")
            let AttacksArray = AttackArray(attackNumber: Attack.key!, attack: Attack)
            self.isFinishedPaging = pagingResult
            self.Attacks.append(AttacksArray)
            self.tableView.reloadData()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! AttackTableViewCell? ?? AttackTableViewCell(style: .default, reuseIdentifier: cellID)
        cell.graphViewController = self
        cell.attack = Attacks[indexPath.section].attack
        cell.backgroundColor =  .clear
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Attacks.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Attacks[section].collapsed ? 0 : 1
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == self.Attacks.count - 1 && !isFinishedPaging{
            print("Paginating for post")
            paginatePostWithKey(lastKey: (Attacks.last?.attack.key)!, attackCount: Attacks.count, isFinishedPaging: isFinishedPaging)
            
        }
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        header.setCollapsed(Attacks[section].collapsed)
        header.arrowLabel.text = ">"
        header.section = section
        header.delegate = self
        header.attackDetails = Attacks[section]
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
}

extension GraphViewController: CollapsibleTableViewHeaderDelegate {
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
        let collapsed = !Attacks[section].collapsed
        // Toggle collapse
        Attacks[section].collapsed = collapsed
        header.setCollapsed(collapsed)
        // Reload the whole section
        tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
    }
}
