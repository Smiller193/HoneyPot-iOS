//
//  employeeCell.swift
//  HoneyPot
//
//  Created by Shawn Miller on 4/11/18.
//  Copyright © 2018 HoneyPot. All rights reserved.
//

import UIKit

class employeeCell: BaseCell {
    var coworker: User?{
        didSet{
            let imageURL = URL(string: (coworker?.profilePic)!)
            self.profileImage.af_setImage(withURL: imageURL!)
            friendNameLabel.text = coworker?.username.capitalized
        }
    }
    var dividerView: UIView?

    lazy var profileImage: CustomImageView = {
        let profilePicture = CustomImageView()
        profilePicture.clipsToBounds = true
        profilePicture.translatesAutoresizingMaskIntoConstraints = false
        profilePicture.contentMode = .scaleAspectFit
        profilePicture.isUserInteractionEnabled = true
        profilePicture.layer.shouldRasterize = true
        //        profilePicture.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleZoomTap)))
        // will allow you to add a target to an image click
        profilePicture.layer.masksToBounds = true
        return profilePicture
    }()
    
    let friendNameLabel : UILabel =  {
        let friendNameLabel = UILabel()
        friendNameLabel.font = UIFont(name:"Avenir-Heavy", size: 18)
        return friendNameLabel
    }()
    
    
    override func setupViews() {
        addSubview(profileImage)
        profileImage.backgroundColor = .clear
        profileImage.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self.snp.left).offset(5)
            make.height.width.equalTo(55)
        }
        profileImage.layer.cornerRadius = 55/2
        
        dividerView = UIView()
        dividerView?.backgroundColor = UIColor.lightGray
        addSubview(dividerView!)
        dividerView?.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.50)
        
        addSubview(friendNameLabel)
        friendNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(profileImage.snp.right).offset(5)
            make.centerY.equalTo(self.snp.centerY)
        }
    }
}
