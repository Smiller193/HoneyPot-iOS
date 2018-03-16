//
//  NSLayoutConstraint.swift
//  HoneyPot
//
//  Created by Shawn Miller on 3/16/18.
//  Copyright © 2018 HoneyPot. All rights reserved.
//

import Foundation
import UIKit

extension NSLayoutConstraint {
    
    static func activateViewConstraints(_ view:UIView, inSuperView superView:UIView, withLeading leadingCons:CGFloat?, trailing trailingCons:CGFloat?, top topCons:CGFloat?, bottom bottomCons:CGFloat?) {
        if leadingCons != nil {
            _ = NSLayoutConstraint.activateLeadingConstraint(withView: view, superView: superView, andSeparation: leadingCons!)
        }
        if trailingCons != nil {
            _ = NSLayoutConstraint.activateTrailingConstraint(withView: view, superView: superView, andSeparation: trailingCons!)
        }
        if topCons != nil {
            _ = NSLayoutConstraint.activateTopConstraint(withView: view, superView: superView, andSeparation: topCons!)
        }
        if bottomCons != nil {
            _ = NSLayoutConstraint.activateBottomConstraint(withView: view, superView: superView, andSeparation: bottomCons!)
        }
    }
    
    static func activateViewConstraints(_ view:UIView, inSuperView superView:UIView?, withLeading leadingCons:CGFloat?, trailing trailingCons:CGFloat?, top topCons:CGFloat?, bottom bottomCons:CGFloat?, width widthCons:CGFloat?, height heightCons:CGFloat?) {
        if superView != nil {
            NSLayoutConstraint.activateViewConstraints(view, inSuperView: superView!, withLeading: leadingCons, trailing: trailingCons, top: topCons, bottom: bottomCons)
        }
        if widthCons != nil {
            _ = NSLayoutConstraint.activateWidthConstraint(view: view, withWidth: widthCons!)
        }
        if heightCons != nil {
            _ = NSLayoutConstraint.activateHeightConstraint(view: view, withHeight: heightCons!)
        }
    }
    
    static func activateWidthConstraint(view theView:UIView, withWidth width:CGFloat) -> NSLayoutConstraint {
        let cons = NSLayoutConstraint.addWidthConstraint(view: theView, withWidth: width, andRelation: .equal)
        NSLayoutConstraint.activate([cons])
        return cons
    }
    
    static func activateWidthConstraint(view theView:UIView, withWidth width:CGFloat, andRelation relation:NSLayoutRelation) -> NSLayoutConstraint {
        let cons = NSLayoutConstraint.addWidthConstraint(view: theView, withWidth: width, andRelation: relation)
        NSLayoutConstraint.activate([cons])
        return cons
    }
    
    static func addWidthConstraint(view theView:UIView, withWidth width:CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint.addWidthConstraint(view: theView, withWidth: width, andRelation: .equal)
    }
    
    static func addWidthConstraint(view theView:UIView, withWidth width:CGFloat, andRelation relation:NSLayoutRelation) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: theView,
                                  attribute: .width,
                                  relatedBy: relation,
                                  toItem: nil,
                                  attribute: .notAnAttribute,
                                  multiplier: 1.0,
                                  constant: width)
    }
    
    static func activateHeightConstraint(view theView:UIView, withHeight height:CGFloat) -> NSLayoutConstraint {
        let cons = NSLayoutConstraint.addHeightConstraint(view: theView, withHeight: height, andRelation: .equal)
        NSLayoutConstraint.activate([cons])
        return cons
    }
    
    static func activateHeightConstraint(view theView:UIView, withHeight height:CGFloat, andRelation relation:NSLayoutRelation) -> NSLayoutConstraint {
        let cons = NSLayoutConstraint.addHeightConstraint(view: theView, withHeight: height, andRelation: relation)
        NSLayoutConstraint.activate([cons])
        return cons
    }
    
    static func addHeightConstraint(view theView:UIView, withHeight height:CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint.addHeightConstraint(view: theView, withHeight: height, andRelation: .equal)
    }
    
    static func addHeightConstraint(view theView:UIView, withHeight height:CGFloat, andRelation relation:NSLayoutRelation) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: theView,
                                  attribute: .height,
                                  relatedBy: relation,
                                  toItem: nil,
                                  attribute: .notAnAttribute,
                                  multiplier: 1.0,
                                  constant: height)
    }
    
    static func activateTrailingConstraint(withView view:UIView, superView supView:UIView, andSeparation separation:CGFloat) -> NSLayoutConstraint {
        let trailing = NSLayoutConstraint.addTrailingConstraint(withView: view, superView: supView, andSeparation: separation)
        NSLayoutConstraint.activate([trailing])
        return trailing
    }
    
    static func addTrailingConstraint(withView view:UIView, superView supView:UIView, andSeparation separation:CGFloat) -> NSLayoutConstraint {
        let trailing = NSLayoutConstraint(item: view,
                                          attribute: .trailing,
                                          relatedBy: .equal,
                                          toItem: supView,
                                          attribute: .trailing,
                                          multiplier: 1.0,
                                          constant: separation)
        return trailing
    }
    
    static func activateLeadingConstraint(withView view:UIView, superView supView:UIView, andSeparation separation:CGFloat) -> NSLayoutConstraint {
        let leading = NSLayoutConstraint.addLeadingConstraint(withView: view, superView: supView, andSeparation: separation)
        NSLayoutConstraint.activate([leading])
        return leading
    }
    
    static func addLeadingConstraint(withView view:UIView, superView supView:UIView, andSeparation separation:CGFloat) -> NSLayoutConstraint {
        let leading = NSLayoutConstraint(item: view,
                                         attribute: .leading,
                                         relatedBy: .equal,
                                         toItem: supView,
                                         attribute: .leading,
                                         multiplier: 1.0,
                                         constant: separation)
        return leading
    }
    
    static func activateHorizontalSpacingConstraint(withFirstView fView:UIView, secondView sView:UIView, andSeparation separation:CGFloat) -> NSLayoutConstraint {
        let cons = NSLayoutConstraint.addHorizontalSpacingConstraint(withFirstView: fView, secondView: sView, andSeparation: separation)
        NSLayoutConstraint.activate([cons])
        return cons
    }
    
    static func addHorizontalSpacingConstraint(withFirstView fView:UIView, secondView sView:UIView, andSeparation separation:CGFloat) -> NSLayoutConstraint {
        let cons = NSLayoutConstraint(item: sView,
                                      attribute: .left,
                                      relatedBy: .equal,
                                      toItem: fView,
                                      attribute: .right,
                                      multiplier: 1.0,
                                      constant: separation)
        return cons
    }
    
    static func activateTopConstraint(withView view:UIView, superView supView:UIView, andSeparation separation:CGFloat) -> NSLayoutConstraint {
        let top = NSLayoutConstraint.addTopConstraint(withView: view, superView: supView, andSeparation: separation)
        NSLayoutConstraint.activate([top])
        return top
    }
    
    static func addTopConstraint(withView view:UIView, superView supView:UIView, andSeparation separation:CGFloat) -> NSLayoutConstraint {
        let top = NSLayoutConstraint(item: view,
                                     attribute: .top,
                                     relatedBy: .equal,
                                     toItem: supView,
                                     attribute: .top,
                                     multiplier: 1.0,
                                     constant: separation)
        return top
    }
    
    
    static func activateBottomConstraint(withView view:UIView, superView supView:UIView, andSeparation separation:CGFloat) -> NSLayoutConstraint {
        let bottom = NSLayoutConstraint.addBottomConstraint(withView: view, superView: supView, andSeparation: separation)
        NSLayoutConstraint.activate([bottom])
        return bottom
    }
    
    static func addBottomConstraint(withView view:UIView, superView supView:UIView, andSeparation separation:CGFloat) -> NSLayoutConstraint {
        let bottom = NSLayoutConstraint(item: view,
                                        attribute: .bottom,
                                        relatedBy: .equal,
                                        toItem: supView,
                                        attribute: .bottom,
                                        multiplier: 1.0,
                                        constant: separation)
        return bottom
    }
    
    static func activateVerticalSpacingConstraint(withFirstView fView:Any, secondView sView:Any, andSeparation separation:CGFloat) -> NSLayoutConstraint {
        let cons = NSLayoutConstraint.addVerticalSpacingConstraint(withFirstView: fView, secondView: sView, andSeparation: separation)
        NSLayoutConstraint.activate([cons])
        return cons
    }
    
    static func addVerticalSpacingConstraint(withFirstView fView:Any, secondView sView:Any, andSeparation separation:CGFloat) -> NSLayoutConstraint {
        let cons = NSLayoutConstraint(item: sView,
                                      attribute: .top,
                                      relatedBy: .equal,
                                      toItem: fView,
                                      attribute: .bottom,
                                      multiplier: 1.0,
                                      constant: separation)
        return cons
    }
    
    static func activateCentreXConstraint(withView view:UIView, superView supView:UIView, andConstant constantK:CGFloat) -> NSLayoutConstraint {
        let cons = NSLayoutConstraint.addCentreXConstraint(withView: view, superView: supView, andConstant: constantK)
        NSLayoutConstraint.activate([cons])
        return cons
    }
    
    static func activateCentreXConstraint(withView view:UIView, superView supView:UIView) -> NSLayoutConstraint {
        let cons = NSLayoutConstraint.addCentreXConstraint(withView: view, superView: supView, andConstant: 0.0)
        NSLayoutConstraint.activate([cons])
        return cons
    }
    
    static func addCentreXConstraint(withView view:UIView, superView supView:UIView, andConstant constantK:CGFloat) -> NSLayoutConstraint {
        let cons = NSLayoutConstraint(item: view,
                                      attribute: .centerX,
                                      relatedBy: .equal,
                                      toItem: supView,
                                      attribute: .centerX,
                                      multiplier: 1.0,
                                      constant: constantK)
        return cons
    }
    
    static func addCentreXConstraint(withView view:UIView, superView supView:UIView) -> NSLayoutConstraint {
        return NSLayoutConstraint.addCentreXConstraint(withView: view, superView: supView, andConstant: 0.0)
    }
    
    
    static func activateCentreYConstraint(withView view:UIView, superView supView:UIView, andConstant constantK:CGFloat) -> NSLayoutConstraint {
        let cons = NSLayoutConstraint.addCentreYConstraint(withView: view, superView: supView, andConstant: constantK)
        NSLayoutConstraint.activate([cons])
        return cons
    }
    
    static func activateCentreYConstraint(withView view:UIView, superView supView:UIView) -> NSLayoutConstraint {
        let cons = NSLayoutConstraint.addCentreYConstraint(withView: view, superView: supView, andConstant: 0.0)
        NSLayoutConstraint.activate([cons])
        return cons
    }
    
    static func addCentreYConstraint(withView view:UIView, superView supView:UIView, andConstant constantK:CGFloat) -> NSLayoutConstraint {
        let cons = NSLayoutConstraint(item: view,
                                      attribute: .centerY,
                                      relatedBy: .equal,
                                      toItem: supView,
                                      attribute: .centerY,
                                      multiplier: 1.0,
                                      constant: constantK)
        return cons
    }
    
    static func addCentreYConstraint(withView view:UIView, superView supView:UIView) -> NSLayoutConstraint {
        return NSLayoutConstraint.addCentreXConstraint(withView: view, superView: supView, andConstant: 0.0)
    }
    
    static func activateEqualWidthConstraint(withView view:UIView, referenceView refView:UIView) -> NSLayoutConstraint {
        let cons = NSLayoutConstraint.addEqualWidthConstraint(withView: view, referenceView: refView, multiplier: 1.0)
        NSLayoutConstraint.activate([cons])
        return cons
    }
    
    static func activateEqualWidthConstraint(withView view:UIView, referenceView refView:UIView, multiplier m:CGFloat) -> NSLayoutConstraint {
        let cons = NSLayoutConstraint.addEqualWidthConstraint(withView: view, referenceView: refView, multiplier: m)
        NSLayoutConstraint.activate([cons])
        return cons
    }
    
    static func addEqualWidthConstraint(withView view:UIView, referenceView refView:UIView) -> NSLayoutConstraint {
        return NSLayoutConstraint.addEqualWidthConstraint(withView: view, referenceView: refView, multiplier: 1.0)
    }
    
    static func addEqualWidthConstraint(withView view:UIView, referenceView refView:UIView, multiplier m:CGFloat) -> NSLayoutConstraint {
        let cons = NSLayoutConstraint(item: view,
                                      attribute: .width,
                                      relatedBy: .equal,
                                      toItem: refView,
                                      attribute: .width,
                                      multiplier: m,
                                      constant: 0.0)
        return cons
    }
    
    static func activateEqualHeightConstraint(withView view:UIView, referenceView refView:UIView) -> NSLayoutConstraint {
        let cons = NSLayoutConstraint.addEqualHeightConstraint(withView: view, referenceView: refView, multiplier: 1.0)
        NSLayoutConstraint.activate([cons])
        return cons
    }
    
    static func activateEqualHeightConstraint(withView view:UIView, referenceView refView:UIView, multiplier m:CGFloat) -> NSLayoutConstraint {
        let cons = NSLayoutConstraint.addEqualHeightConstraint(withView: view, referenceView: refView, multiplier: m)
        NSLayoutConstraint.activate([cons])
        return cons
    }
    
    static func addEqualHeightConstraint(withView view:UIView, referenceView refView:UIView, multiplier m:CGFloat) -> NSLayoutConstraint {
        let cons = NSLayoutConstraint(item: view,
                                      attribute: .height,
                                      relatedBy: .equal,
                                      toItem: refView,
                                      attribute: .height,
                                      multiplier: m,
                                      constant: 0.0)
        return cons
    }
    
    static func addEqualHeightConstraint(withView view:UIView, referenceView refView:UIView) -> NSLayoutConstraint {
        return NSLayoutConstraint.addEqualHeightConstraint(withView: view, referenceView: refView, multiplier: 1.0)
    }
}
