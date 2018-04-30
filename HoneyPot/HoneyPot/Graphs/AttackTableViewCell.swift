//
//  AttackTableViewCell.swift
//  HoneyPot
//
//  Created by Shawn Miller on 4/23/18.
//  Copyright © 2018 HoneyPot. All rights reserved.
//

import UIKit


class AttackTableViewCell: UITableViewCell {
    var stackView: UIStackView?
    var stackView2: UIStackView?

    var urlContents = ""
    var navTitle = ""

    var attack : Attack? {
        didSet{
            stackView?.removeFromSuperview()
            stackView2?.removeFromSuperview()
            guard let currentAttack = attack else {
                return
            }
            if let attackerID = currentAttack.attackerID, let ipAddy = currentAttack.ip_address,
                let userName = currentAttack.ip_address, let passWords = currentAttack.passwords,
            let timeOfDay = currentAttack.time_of_day_accessed, let logfile = currentAttack.logFile,
                let sessions = currentAttack.sessions, let country = currentAttack.country,let city = currentAttack.city,let state = currentAttack.state,let dateAccessed = currentAttack.dateAccessed,let long = currentAttack.longitude, let lat = currentAttack.latitude{
                attackerIDLabel.text = "Attacker ID: \(attackerID)"
                ipAddress.text = "Attacker IpAddress:\(ipAddy)"
                username.text = "Attacker Username:\(userName))"
                passwords.text = "Attacker Passwords:\(passWords)"
                timeOfDayAcessed.text = "Time Accessed By Attacker:\(timeOfDay)"
                logFile.text = "Log File:\(logfile)"
                sessionsLabel.text = "sessions:\(sessions)"
                countryLabel.text = "Attacke Country:\(country)"
                cityLabel.text = "Attacker City:\(city)"
                stateLabel.text = "Attacker State:\(state)"
                dateAccessedLabel.text = "Date Accessed:\(dateAccessed)"
                longitude.text = "longitude:\(long)"
                latitude.text = "latitude:\(lat)"
                setupCell()
            }
            if currentAttack.attackerID == nil {
                if let dateAccessed = currentAttack.dateAccessed,let ipAddy = currentAttack.ip_address, let logFIle = currentAttack.logFile, let passwords2 = currentAttack.passwords,let timeOfDay = currentAttack.time_of_day_accessed, let username1 = currentAttack.username{
                    dateAccessedLabel.text = "Date Accessed:\(dateAccessed)"
                    ipAddress.text = "IpAddress:\(ipAddy)"
                    logFile.text = "Log File:\(logFIle)"
                    passwords.text = "Passwords:\(passwords2)"
                    timeOfDayAcessed.text = "Time Accessed:\(timeOfDay)"
                    username.text = "Username:\(username1))"
                    setupCell2()
                }
            }


        }
    }
    
    var graphViewController:GraphViewController?
    
    let attackerIDLabel:UILabel={
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13.5)
        label.numberOfLines = 0
        return label
    }()
    let ipAddress:UILabel={
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13.5)
        label.numberOfLines = 0
        return label
    }()
    let username:UILabel={
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13.5)
        label.numberOfLines = 0
        return label
    }()
    let passwords:UILabel={
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13.5)
        label.numberOfLines = 0
        return label
    }()
    let timeOfDayAcessed:UILabel={
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13.5)
        label.numberOfLines = 0
        return label
    }()
    let logFile:UILabel={
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13.5)
        label.numberOfLines = 0
        return label
    }()
    
 
    let sessionsLabel:UILabel={
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13.5)
        label.numberOfLines = 0
        return label
    }()
    let countryLabel:UILabel={
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13.5)
        label.numberOfLines = 0
        return label
    }()
    let cityLabel:UILabel={
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13.5)
        label.numberOfLines = 0
        return label
    }()
    let stateLabel:UILabel={
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13.5)
        label.numberOfLines = 0
        return label
    }()
    let dateAccessedLabel:UILabel={
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13.5)
        label.numberOfLines = 0
        return label
    }()
    let longitude:UILabel={
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13.5)
        label.numberOfLines = 0
        return label
    }()
    let latitude:UILabel={
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13.5)
        label.numberOfLines = 0
        return label
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       

    }
    @objc func setupCell() {
        stackView = UIStackView(arrangedSubviews: [attackerIDLabel,ipAddress,username,passwords,timeOfDayAcessed,logFile,sessionsLabel,countryLabel,cityLabel,stateLabel,dateAccessedLabel,longitude,latitude])
        stackView?.distribution = .fillEqually
        stackView?.axis = .vertical
        addSubview(stackView!)
        stackView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self).inset(3)
        })
        self.logFile.isUserInteractionEnabled = true
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(showLogFiles))
        self.logFile.addGestureRecognizer(recognizer)
    }
    
    @objc func setupCell2(){
        print("setting up cells")
        stackView2 = UIStackView(arrangedSubviews: [dateAccessedLabel,ipAddress,logFile,passwords,timeOfDayAcessed,username])
        stackView2?.distribution = .fillEqually
        stackView2?.axis = .vertical
        stackView2?.spacing = 5.0
        addSubview(stackView2!)
        stackView2?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self).inset(3)
        })
        self.logFile.isUserInteractionEnabled = true
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(showLogFiles))
        self.logFile.addGestureRecognizer(recognizer)
    }
    
    @objc func showLogFiles(){
        print("logfile has been tapped")
        print(logFile.text!)
        let logFileTextPath = logFile.text?.components(separatedBy: ":")
        print(logFileTextPath![1])
        self.navTitle = logFileTextPath![1]
        var urlString = "http://18.218.88.192:8080/ActiveHoneypotWeb/logfiles/\(logFileTextPath![1])"
        grabTextFile(urlString: urlString, navTitle: logFileTextPath![1])
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
       var finalContents = urlContents.replacingOccurrences(of: "/<br/>", with: "")
        finalContents = finalContents.replacingOccurrences(of: "<br/>", with: "")
        print(finalContents)
        logFileVC.textView.text = finalContents
        print(self.urlContents)
        self.graphViewController?.navigationController?.pushViewController(logFileVC, animated: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
