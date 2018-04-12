//
//  BaseCell.swift
//  HoneyPot
//
//  Created by Shawn Miller on 4/11/18.
//  Copyright © 2018 HoneyPot. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    @objc func setupViews(){
        backgroundColor = .blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
