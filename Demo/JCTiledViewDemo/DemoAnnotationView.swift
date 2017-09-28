//
//  DemoAnnotationView.swift
//  JCTiledViewDemo
//
//  Created by Jesse Collis on 28/9/17.
//  Copyright © 2017 JC Multimedia Design. All rights reserved.
//

import JCTiledScrollView

class DemoAnnotationView: JCAnnotationView {
  var imageView: UIImageView?
  
  override init(frame: CGRect, annotation: JCAnnotation, reuseIdentifier: String) {
    super.init(frame: frame, annotation: annotation, reuseIdentifier: reuseIdentifier)
    
    setupImageView()
  }

  //FIXME: init with coder is not correctly supported here or in the base class.
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  private func setupImageView() {
    imageView = UIImageView()
    addSubview(imageView!)
  }
  
  override func sizeThatFits(_ size: CGSize) -> CGSize {
    guard let imageView = self.imageView else { fatalError() }

    if let imageSize = imageView.image?.size {
      return imageSize;
    }
    
    return CGSize(width: 30, height: 30)
  }

  override func layoutSubviews() {
    guard let imageView = self.imageView else { fatalError() }
    
    imageView.sizeToFit()
    imageView.frame = CGRect(x: 0, y: 0, width: imageView.frame.width, height:imageView.frame.height);
  }
}
