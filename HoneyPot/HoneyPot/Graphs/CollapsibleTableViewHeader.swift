//
//  CollapsibleTableViewHeader.swift
//  HoneyPot
//
//  Created by Shawn Miller on 4/23/18.
//  Copyright © 2018 HoneyPot. All rights reserved.
//

import UIKit
protocol CollapsibleTableViewHeaderDelegate {
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int)
}

class CollapsibleTableViewHeader: UITableViewHeaderFooterView {
    var delegate: CollapsibleTableViewHeaderDelegate?
    var section: Int = 0
    let arrowLabel: UILabel = {
        let arrowLabel = UILabel()
        arrowLabel.textColor = .black
        return arrowLabel
    }()
    let attackLabel: UILabel = {
        let attackLabel = UILabel()
        attackLabel.textColor = .black
        return attackLabel
    }()
    var attackDetails: AttackArray?{
        didSet {
            var name = 0
            if let value = attackDetails?.attack.attackerID {
                name = value
                attackLabel.text = "Attack"
            }else{
                attackLabel.text = "Attack"

            }
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setUpCell()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CollapsibleTableViewHeader.tapHeader(_:))))
        //        contentView.addSubview(arrowLabel)
    }
    
    @objc func tapHeader(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let cell = gestureRecognizer.view as? CollapsibleTableViewHeader else {
            return
        }
        delegate?.toggleSection(self, section: cell.section)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCell(){
        addSubview(arrowLabel)
        addSubview(attackLabel)
        arrowLabel.textColor = UIColor.black
        arrowLabel.translatesAutoresizingMaskIntoConstraints = false
        arrowLabel.widthAnchor.constraint(equalToConstant: 12).isActive = true
        arrowLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        arrowLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        arrowLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        attackLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self.snp.left).offset(3)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
    
    func setCollapsed(_ collapsed: Bool) {
        // Animate the arrow rotation (see Extensions.swf)
        print(collapsed)
        //0.0
        arrowLabel.rotate(collapsed ? 0.0:.pi / 2)
    }


    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
