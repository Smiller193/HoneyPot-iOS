//
//  Home.swift
//  HoneyPot
//
//  Created by Shawn Miller on 4/22/18.
//  Copyright © 2018 HoneyPot. All rights reserved.
//

import Foundation
protocol HomeProtocol: class {
    func itemsDownloaded(items: NSArray)
}

class Home: NSObject, URLSessionDataDelegate{
    weak var delegate: HomeProtocol!
    var data = Data()
    let urlPath: String = "jdbc:mysql://activehoneypot-instance1.c6cgtt72anqv.us-west-2.rds.amazonaws.com"
    
    func downloadItems() {
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data: \(String(describing: error))")
            }else {
                print("Data downloaded")
                self.parseJSON(data!)
            }
            
        }
        
        task.resume()
    }
    
    
    func parseJSON(_ data:Data) {
        
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            
        } catch let error as NSError {
            print(error)
            
        }
        
        var jsonElement = NSDictionary()
        let attacks = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let attack = Attack()
            
            //the following insures none of the JsonElement values are nil through optional binding
            if let attackerID = jsonElement["attackerID"] as? Int,
                let ipAddress = jsonElement["ipAddress"] as? String,
                let username = jsonElement["username"] as? String,
                let passwords = jsonElement["passwords"] as? String,
                let timeOfDayAcessed = jsonElement["timeOfDayAcessed"] as? TimeInterval,
                let logFile = jsonElement["logFile"] as? String,
                let sessions = jsonElement["sessions"] as? Int,
                let country = jsonElement["country"] as? String,
                let city = jsonElement["city"] as? String,
                let state = jsonElement["state"] as? String,
                let loggedIn = jsonElement["loggedIn"] as? String,
                let uploadFiles = jsonElement["uploadFiles"] as? String,
                let dateAccessed = jsonElement["dateAccessed"] as? Date,
                let longitude = jsonElement["longitude"] as? String,
                let latitude = jsonElement["latitude"] as? String
            {
                
                attack.ipAddress = ipAddress
                attack.username = username
                attack.passwords = passwords
                attack.timeOfDayAcessed = timeOfDayAcessed
                
                attack.logFile = logFile
                attack.sessions = sessions
                attack.country = country
                attack.city = city
                
                attack.state = state
                attack.loggedIn = loggedIn
                attack.uploadFiles = uploadFiles
                attack.dateAccessed = dateAccessed
                
                attack.longitude = longitude
                attack.latitude = latitude
                
            }
            
            attacks.add(attack)
            
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.itemsDownloaded(items: attacks)
            
        })
    }
}
