//
//  UIView+Extensions.swift
//  JCTiledViewDemo
//
//  Created by Jesse Collis on 28/9/17.
//  Copyright © 2017 JC Multimedia Design. All rights reserved.
//

import UIKit

extension UIView {
  
  @discardableResult
  public func activateSuperviewHuggingConstraints(_ insets: UIEdgeInsets = UIEdgeInsets.zero) -> [NSLayoutConstraint] {
    translatesAutoresizingMaskIntoConstraints = false
    
    let views = ["view": self]
    let metrics = ["top": insets.top, "left": insets.left, "bottom": insets.bottom, "right": insets.right]
    var constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-left-[view]-right-|", options: [], metrics: metrics, views: views)
    constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|-top-[view]-bottom-|", options: [], metrics: metrics, views: views))
    NSLayoutConstraint.activate(constraints)
    
    return constraints
  }
}
