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
        let attackRef = Database.database().reference().child("recordList")
        let value = lastKey
        var query = attackRef.queryOrderedByKey()
        if currentAttackCount > 0 {
            query = query.queryStarting(atValue: value)
        }
        query.queryLimited(toFirst: 14).observeSingleEvent(of: .value, with: { (snapshot) in
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
                print(objects.key)
                guard let attack = Attack(snapshot: objects) else {
                    return
                }
                completion(attack,pagingDone)
            }
  
            
        }) { (err) in
            print(err)
            print("failed to paginate post")
        }
     
    }
}
