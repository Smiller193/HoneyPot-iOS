//
//  AttackArray.swift
//  HoneyPot
//
//  Created by Shawn Miller on 4/23/18.
//  Copyright © 2018 HoneyPot. All rights reserved.
//

import Foundation

class AttackArray: NSObject {
    var attackNumber: String?
    var attack: Attack
    var collapsed: Bool
    init(attackNumber: String, attack: Attack ,collapsed: Bool = true) {
        self.attackNumber = attackNumber
        self.attack = attack
        self.collapsed = collapsed
    }
}
