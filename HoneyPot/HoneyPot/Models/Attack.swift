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
    var attackerID: Int?
    var city: String?
    var country: String?
    var date_accessed: String?
    var ip_address: String?
    var latitude: String?
    var logFile: String?
    var longitude: String?
    var passwords: String?
    var sessions: Int?
    var state: String?
    var time_of_day_accessed: String?
    var dateAccessed: String?
    var username: String?

    


    
    override init()
    {
        
    }
    
    
    init(attackerID: Int, ip_address: String, latitude: String, longitude: String,username: String, passwords: String,time_of_day_accessed: String,logFile: String,sessions: Int,country: String,city: String,state: String,loggedIn: String,uploadFiles: String,dateAccessed: String) {
        self.attackerID = attackerID
        self.ip_address = ip_address
        self.latitude = latitude
        self.longitude = longitude
        self.username = username
        self.passwords = passwords
        self.time_of_day_accessed = time_of_day_accessed
        self.logFile = logFile
        self.sessions = sessions
        self.country = country
        self.city = city
        self.state = state
        self.dateAccessed = dateAccessed
    }
    //User init using Firebase snapshots
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let attackerID = dict["attackerID"] as? Int,
            let city = dict["city"] as? String,
            let country = dict["country"] as? String,
            let dateAccessed = dict["date_accessed"] as? String,
            let ip_address = dict["ip_address"] as? String,
            let latitude = dict["latitude"] as? String,
            let longitude = dict["longitude"] as? String,
            let logFile = dict["logFile"] as? String,
            let passwords = dict["passwords"] as? String,
            let sessions = dict["sessions"] as? Int,
            let state = dict["state"] as? String,
            let time_of_day_accessed = dict["time_of_day_accessed"] as? String,
            let username = dict["username"] as? String
            else { return nil }
        self.key = snapshot.key
        self.attackerID = attackerID
        self.city = city
        self.country = country
        self.dateAccessed = dateAccessed
        self.ip_address = ip_address
        self.latitude = latitude
        self.longitude = longitude
        self.logFile = logFile
        self.passwords = passwords
        self.sessions = sessions
        self.state = state
        self.time_of_day_accessed = time_of_day_accessed
        self.username = username
    }
    
    init?(invalidLoginSnapshot: DataSnapshot){
        guard let dict = invalidLoginSnapshot.value as? [String: Any],
        let city = dict["city"] as? String,
        let country = dict["country"] as? String,
        let dateAccessed = dict["date_accessed"] as? String,
        let ip_address = dict["ip_address"] as? String,
        let logFile = dict["logFile"] as? String,
        let passwords = dict["passwords"] as? String,
        let state = dict["state"] as? String,
        let time_of_day_accessed = dict["time_of_day_accessed"] as? String,
        let username = dict["username"] as? String
            else {return nil}
        self.key = invalidLoginSnapshot.key
        self.city = city
        self.country = country
        self.dateAccessed = dateAccessed
        self.ip_address = ip_address
        self.logFile = logFile
        self.passwords = passwords
        self.state = state
        self.time_of_day_accessed = time_of_day_accessed
        self.username = username
    }
    
    
    override var description: String {
        return "attackerID: \(String(describing: attackerID)), Address: \(String(describing: ip_address)), Latitude: \(String(describing: latitude)), Longitude: \(String(describing: longitude)),username: \(String(describing: username)), passwords: \(String(describing: passwords)), timeOfDayAcessed: \(String(describing: time_of_day_accessed)), logFile: \(String(describing: logFile)),sessions: \(String(describing: sessions)), country: \(String(describing: country)), city: \(String(describing: city)), state: \(String(describing: state)), dateAccessed: \(String(describing: dateAccessed))"
        
    }
    
    
    
}
