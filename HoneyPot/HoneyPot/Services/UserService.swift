//
//  UserService.swift
//  HoneyPot
//
//  Created by Shawn Miller on 3/26/18.
//  Copyright © 2018 HoneyPot. All rights reserved.
//

import Foundation
import Firebase
import  UIKit



struct UserService {
    /// will create a user in the database
    static func create(_ firUser: FIRUser, username: String,profilePic: String, completion: @escaping (User?) -> Void) {
        //  print(profilePic)
        //   print(username)
//        guard let fcmToken = Messaging.messaging().fcmToken else {
//            return
//        }
        
        print("")
        let userAttrs = ["username": username,
                         "profilePic": profilePic] as [String : Any]
        //creats the path in the database where we want our user attributes to be created
        //Also sets the value at that point in the tree to the user Attributes array
        let ref = Database.database().reference().child("users").child(firUser.uid)
        ref.setValue(userAttrs) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                let user = User(snapshot: snapshot)
                completion(user)
            })
        }
    }
    // Will update device token for the user
//    static func updateDeviceToken(deviceToken: String, userId: String){
//        let userAttrs = ["fcmToken": deviceToken] as [String : Any]
//
//        let ref = Database.database().reference().child("users").child(userId)
//        ref.updateChildValues(userAttrs){ (error, ref) in
//            if let error = error {
//                assertionFailure(error.localizedDescription)
//                return
//            }
//            ref.observeSingleEvent(of: .value, with: { (snapshot) in
//                let updatedUser = User(snapshot: snapshot)
//                print(updatedUser as Any)
//            })
//        }
//    }
    //Will allow you to edit user data in firebase
    static func edit(username: String, completion: @escaping (User?) -> Void) {
        let userAttrs = ["username": username] as [String : Any]
        
        let ref = Database.database().reference().child("users").child(User.current.uid)
        ref.updateChildValues(userAttrs) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                let user = User(snapshot: snapshot)
                completion(user)
            })
        }
    }
    // will strictly handle editing the user section in the database
    static func editProfileImage(url: String, completion: @escaping (User?) -> Void) {
        // print(url)
        
        let userAttrs = ["profilePic": url]
        let ref = Database.database().reference().child("users").child(User.current.uid)
        ref.updateChildValues(userAttrs) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                let user = User(snapshot: snapshot)
                completion(user)
            })
        }
    }
    
    // will observe the user object in the database for any changes and make sure that they are updated
//    static func observeProfile(for user: User, completion: @escaping (DatabaseReference, User?, [Event]) -> Void) -> DatabaseHandle {
//        // 1
//        let userRef = Database.database().reference().child("users").child(user.uid)
//
//        // 2
//        return userRef.observe(.value, with: { snapshot in
//            // 3
//            // print(snapshot)
//            guard let user = User(snapshot: snapshot) else {
//                return completion(userRef, nil, [])
//            }
//
//            //  print(user)
//            // print(user.uid)
//            // 4
//            Events(for: user, completion: { events in
//                // 5
//                completion(userRef, user, events)
//            })
//        })
//    }
    
    
    
    //shows the data at the user endpoint
    //observeSingleEvent(of:with:) will only trigger the event callback once. This is useful for reading data that only needs to be loaded once and isn't expected to change
    
    static func show(forUID uid: String, completion: @escaping (User?) -> Void) {
        let ref = Database.database().reference().child("users").child(uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let user = User(snapshot: snapshot) else {
                return completion(nil)
                
            }
            
            completion(user)
        })
    }
//
//    static func usersExcludingCurrentUser(completion: @escaping ([User]) -> Void) {
//        let currentUser = User.current
//        // 1
//        let ref = Database.database().reference().child("users")
//
//        // 2
//        ref.observeSingleEvent(of: .value, with: { (snapshot) in
//            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot]
//                else { return completion([]) }
//
//            // 3
//            let users =
//                snapshot
//                    .flatMap(User.init)
//                    .filter { $0.uid != currentUser.uid }
//
//            // 4
//            let dispatchGroup = DispatchGroup()
//            users.forEach { (user) in
//                dispatchGroup.enter()
//
//                // 5
//                FollowService.isUserFollowed(user) { (isFollowed) in
//                    user.isFollowed = isFollowed
//                    dispatchGroup.leave()
//                }
//            }
//
//            // 6
//            dispatchGroup.notify(queue: .main, execute: {
//                completion(users)
//            })
//        })
//    }
    
}

