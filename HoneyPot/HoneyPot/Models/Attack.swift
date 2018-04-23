//
//  Attack.swift
//  HoneyPot
//
//  Created by Shawn Miller on 4/22/18.
//  Copyright © 2018 HoneyPot. All rights reserved.
//

import Foundation
import Firebase

class Attack: NSObject {
    var key: String?
    var attackerID: String?
    var ipAddress: String?
    var username: String?
    var passwords: String?
    var timeOfDayAcessed: String?
    var logFile: String?
    var sessions: String?
    var country: String?
    var city: String?
    var state: String?
    var loggedIn: String?
    var uploadFiles: String?
    var dateAccessed: String?
    var longitude: String?
    var latitude: String?
    var errorMsg: String?
    
    override init()
    {
        
    }
    
    
    init(attackerID: String, ipAddress: String, latitude: String, longitude: String,username: String, passwords: String,timeOfDayAcessed: String,logFile: String,sessions: String,country: String,city: String,state: String,loggedIn: String,uploadFiles: String,dateAccessed: String) {
        self.attackerID = attackerID
        self.ipAddress = ipAddress
        self.latitude = latitude
        self.longitude = longitude
        self.username = username
        self.passwords = passwords
        self.timeOfDayAcessed = timeOfDayAcessed
        self.logFile = logFile
        self.sessions = sessions
        self.country = country
        self.city = city
        self.state = state
        self.loggedIn = loggedIn
        self.uploadFiles = uploadFiles
        self.dateAccessed = dateAccessed
    }
    //User init using Firebase snapshots
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let attackerID = dict["attackerID"] as? String,
            let city = dict["city"] as? String,
            let country = dict["country"] as? String,
            let dateAccessed = dict["date_accessed"] as? String,
            let errorMsg = dict["errorMsg"] as? String,
            let ipAddress = dict["ip_address"] as? String,
            let latitude = dict["latitude"] as? String,
            let longitude = dict["longitude"] as? String,
            let logFile = dict["logFile"] as? String,
            let loggedIn = dict["logged_in"] as? String,
            let passwords = dict["passwords"] as? String,
            let sessions = dict["sessions"] as? String,
            let state = dict["state"] as? String,
            let timeOfDayAcessed = dict["time_of_day_accessed"] as? String,
            let uploadedFiles = dict["uploaded_files"] as? String,
            let username = dict["username"] as? String
            else { return nil }
        self.key = snapshot.key
        self.username = username
        self.attackerID = attackerID
        self.city = city
        self.country = country
        self.dateAccessed = dateAccessed
        self.ipAddress = ipAddress
        self.latitude = latitude
        self.longitude = longitude
        self.logFile = logFile
        self.loggedIn = loggedIn
        self.passwords = passwords
        self.sessions = sessions
        self.state = state
        self.timeOfDayAcessed = timeOfDayAcessed
        self.uploadFiles = uploadedFiles
        self.username = username
        self.errorMsg = errorMsg
    }
    
    
    override var description: String {
        return "attackerID: \(String(describing: attackerID)), Address: \(String(describing: ipAddress)), Latitude: \(String(describing: latitude)), Longitude: \(String(describing: longitude)),username: \(String(describing: username)), passwords: \(String(describing: passwords)), timeOfDayAcessed: \(String(describing: timeOfDayAcessed)), logFile: \(String(describing: logFile)),sessions: \(String(describing: sessions)), country: \(String(describing: country)), city: \(String(describing: city)), state: \(String(describing: state)),uploadFiles: \(String(describing: uploadFiles)), dateAccessed: \(String(describing: dateAccessed)), loggedIn: \(String(describing: loggedIn))"
        
    }
    
    
    
}
