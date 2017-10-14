//
//  DemoAnnotationView.swift
//
//  Copyright (c) 2012-2017 Jesse Collis <jesse@jcmultimedia.com.au>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
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
