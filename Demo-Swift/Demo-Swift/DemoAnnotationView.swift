//
//  DemoAnnotationView.swift
//  Demo-Swift
//
//  Created by Yichi on 13/12/2014.
//  Copyright (c) 2014 Yichi Zhang. All rights reserved.
//

import UIKit

class DemoAnnotationView: JCAnnotationView {
	
	var imageView:UIImageView!
	
	override init!(frame: CGRect, annotation: JCAnnotation!, reuseIdentifier: String!) {
		
		super.init(frame: frame, annotation: annotation, reuseIdentifier: reuseIdentifier)
		imageView = UIImageView()
		addSubview(imageView)
		
	}
	
	required init(coder aDecoder: NSCoder) {
		
		super.init(coder: aDecoder);
	}
	
	override func sizeThatFits(size: CGSize) -> CGSize {
		return CGSizeMake(max(imageView.image!.size.width,30), max(imageView.image!.size.height,30));
	}
	
	override func layoutSubviews() {
		
		imageView.sizeToFit();
		imageView.frame = imageView.bounds
	}
	
}
