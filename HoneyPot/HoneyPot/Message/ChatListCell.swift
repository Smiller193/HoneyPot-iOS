//
//  ChatListCell.swift
//  HoneyPot
//
//  Created by Shawn Miller on 4/11/18.
//  Copyright © 2018 HoneyPot. All rights reserved.
//

import UIKit
import SnapKit
import AlamofireImage

class ChatListCell: BaseCell {
    var chatUser: User?{
        didSet{
            let imageURL = URL(string: (chatUser?.profilePic)!)
            self.profileImage.af_setImage(withURL: imageURL!)
            friendNameLabel.text = chatUser?.username?.capitalized
        }
    }
    var dividerView: UIView?

    
    lazy var profileImage: CustomImageView = {
        let profilePicture = CustomImageView()
        profilePicture.clipsToBounds = true
        profilePicture.translatesAutoresizingMaskIntoConstraints = false
        profilePicture.contentMode = .scaleToFill
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
    let messageLabel : UILabel =  {
        let messageLabel = UILabel()
        messageLabel.text = "Your friends message and something else...."
        messageLabel.font = UIFont(name:"Avenir", size: 14)
        return messageLabel
    }()
    
    let timeLabel : UILabel =  {
        let timeLabel = UILabel()
        timeLabel.textAlignment = .right
        timeLabel.text = "12:00 PM"
        timeLabel.font = UIFont(name:"Avenir-Light", size: 12)
        return timeLabel
    }()
    
    override func setupViews(){
        backgroundColor = .clear
        addSubview(profileImage)
        profileImage.backgroundColor = .clear
        profileImage.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self.snp.left).offset(5)
            make.height.width.equalTo(70)
        }
        profileImage.layer.cornerRadius = 70/2
        
        dividerView = UIView()
        dividerView?.backgroundColor = UIColor.lightGray
        addSubview(dividerView!)
        dividerView?.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1)
        setupContainerView()

    }
    
    @objc func setupContainerView(){
        let containerView = UIView()
        containerView.backgroundColor = .clear
        addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(90)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(50)
            make.width.equalTo(self.frame.width)
        }
        
        containerView.addSubview(friendNameLabel)
        friendNameLabel.snp.makeConstraints { (make) in
           make.left.equalTo(containerView)
           make.top.equalTo(containerView.snp.top).offset(3)
        }
        
        containerView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(containerView.snp.top).offset(7)
            make.right.equalTo(containerView).inset(100)
        }
        containerView.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(friendNameLabel.snp.bottom).offset(5)
            make.left.right.equalTo(containerView)
        }
    }
}
