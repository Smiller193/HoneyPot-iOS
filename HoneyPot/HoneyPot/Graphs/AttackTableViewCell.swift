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
    var attack : Attack? {
        didSet{
            guard let currentAttack = attack else {
                return
            }
            attackerID.text = "AttackerID: \(String(describing: currentAttack.attackerID!))"
            ipAddress.text = "AttackerIpAddress:\(String(describing: currentAttack.ipAddress!))"
            username.text = "AttackerUsername:\(String(describing: currentAttack.username!))"
            passwords.text = "AttackerPasswords:\(String(describing: currentAttack.passwords!))"
            timeOfDayAcessed.text = "TimeAccessedByAttacker:\(String(describing: currentAttack.timeOfDayAcessed!))"
            logFile.text = "LogFile:\(String(describing: currentAttack.logFile!))"
            sessions.text = "sessions:\(String(describing: currentAttack.sessions!))"
            country.text = "AttackeCountry:\(String(describing: currentAttack.country!))"
            city.text = "AttackerCity:\(String(describing: currentAttack.city!))"
            state.text = "AttackerState:\(String(describing: currentAttack.state!))"
            loggedIn.text = "LoggedIn:\(String(describing: currentAttack.loggedIn!))"
            uploadFiles.text = "uploadFiles:\(String(describing: currentAttack.uploadFiles!))"
            dateAccessed.text = "dateAccessed:\(String(describing: currentAttack.dateAccessed!))"
            longitude.text = "longitude:\(String(describing: currentAttack.longitude!))"
            latitude.text = "latitude:\(String(describing: currentAttack.latitude!))"
            errorMsg.text = "errorMsg:\(String(describing: currentAttack.errorMsg!))"
        }
    }
    
    let attackerID:UILabel={
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
    let sessions:UILabel={
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13.5)
        label.numberOfLines = 0
        return label
    }()
    let country:UILabel={
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13.5)
        label.numberOfLines = 0
        return label
    }()
    let city:UILabel={
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13.5)
        label.numberOfLines = 0
        return label
    }()
    let state:UILabel={
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13.5)
        label.numberOfLines = 0
        return label
    }()
    let loggedIn:UILabel={
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13.5)
        label.numberOfLines = 0
        return label
    }()
    let uploadFiles:UILabel={
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13.5)
        label.numberOfLines = 0
        return label
    }()
    let dateAccessed:UILabel={
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
    let errorMsg:UILabel={
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
        setupCell()

    }
    @objc func setupCell() {
        stackView = UIStackView(arrangedSubviews: [attackerID,ipAddress,username,passwords,timeOfDayAcessed,logFile,sessions,country,city,state,loggedIn,uploadFiles,dateAccessed,longitude,latitude,errorMsg])
        stackView?.distribution = .fillEqually
        stackView?.axis = .vertical
        stackView?.spacing = 5.0
        addSubview(stackView!)
        stackView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self).inset(3)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
