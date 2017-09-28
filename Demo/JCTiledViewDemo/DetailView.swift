//
//  DetailView.swift
//  JCTiledViewDemo
//
//  Created by Jesse Collis on 28/9/17.
//  Copyright © 2017 JC Multimedia Design. All rights reserved.
//

import UIKit

class DetailView: UIView {
  
  var textLabel: UILabel?
  
  override init(frame: CGRect) {
    
    super.init(frame: frame)

    setupTextLabel()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    setupTextLabel()
  }
  
  private func setupTextLabel() {
    let textLabel = UILabel()
    textLabel.textColor = .white
    textLabel.backgroundColor = .clear
    textLabel.translatesAutoresizingMaskIntoConstraints = false
    self.textLabel = textLabel
    
    addSubview(textLabel)
    
    textLabel.activateSuperviewHuggingConstraints(UIEdgeInsetsMake(2, 2, 2, 2))
  }
}
