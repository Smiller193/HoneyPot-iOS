//
//  AttackService.swift
//  HoneyPot
//
//  Created by Shawn Miller on 4/23/18.
//  Copyright © 2018 HoneyPot. All rights reserved.
//

import Foundation
import Firebase

struct AtackService {
    //will grab all user notifications for database
    static func fetchUserAttack(for lastKey: String,currentAttackCount: Int, isFinishedPaging: Bool,withCompletion completion: @escaping ( Attack,Bool) -> Void){
        var pagingDone = isFinishedPaging
        let attackRef = Database.database().reference().child("attacks")
        let value = lastKey
        var query = attackRef.queryOrderedByKey()
        if currentAttackCount > 0 {
            query = query.queryStarting(atValue: value)
        }
        query.queryLimited(toFirst: 6).observeSingleEvent(of: .value, with: { (snapshot) in
            guard var allObjects = snapshot.children.allObjects as? [DataSnapshot] else{
                return
            }
            if allObjects.count < 1 {
                pagingDone = true
                completion(Attack(),pagingDone)
            }
            if currentAttackCount > 0 {
                allObjects.removeFirst()
            }
            
            for objects in allObjects {
                if objects.childrenCount == 13 {
                    print(objects.key)
                    guard let attack = Attack(snapshot: objects) else {
                        return
                    }
                    completion(attack,pagingDone)
                }
                if objects.childrenCount == 9 {
                    guard let attack = Attack(invalidLoginSnapshot: objects) else {
                        return
                    }
                    completion(attack,pagingDone)
                }
            }
            
        }) { (err) in
            print(err)
            print("failed to paginate post")
        }
     
    }
    
    //will support real time data syncing of attacks
    static func observeAttacks(completion: @escaping (DatabaseReference, Attack?) -> Void) -> DatabaseHandle {
        let attackRef = Database.database().reference().child("attacks")
        return attackRef.observe(.childAdded, with: { snapshot in
            print(snapshot)
            
            if snapshot.childrenCount == 13 {
                guard let attack = Attack(snapshot: snapshot) else {
                    return
                }
                completion(attackRef,attack)
            }
            if snapshot.childrenCount == 9 {
                guard let attack = Attack(invalidLoginSnapshot: snapshot) else {
                    return
                }
                completion(attackRef,attack)
            }
            
        })
    }
    
}
