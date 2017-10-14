//
//  RootViewController.swift
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

import UIKit
import JCTiledScrollView


class RootViewController: UIViewController, JCTileSource, JCTiledScrollViewDelegate {

  var scrollView: JCTiledScrollView!
  @IBOutlet var statusLabel: UILabel!
  @IBOutlet var detailView: UIView!
  
  let skippingGirlImageSize = CGSize(width:432, height:648)
  
  override var canBecomeFirstResponder: Bool {
    return true
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let scrollView = JCTiledScrollView(frame: self.view.frame, contentSize: skippingGirlImageSize)
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    self.scrollView = scrollView
    self.view.insertSubview(scrollView, belowSubview: self.detailView)
    
    let views: [String: UIView] = ["label": self.detailView, "scrollView": scrollView]
    
    self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[scrollView]|",
                                                            options: [],
                                                            metrics: nil,
                                                            views: views))
    self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[label][scrollView]|",
                                                            options: [],
                                                            metrics: nil,
                                                            views: views))
    scrollView.dataSource = self
    scrollView.tiledScrollViewDelegate = self
    scrollView.zoomScale = 1
    
    scrollView.tiledView.shouldAnnotateRect = true
    //  // totals 4 sets of tiles across all devices, retina devices will miss out on the first 1x set
    scrollView.levelsOfZoom = 3
    scrollView.levelsOfDetail = 3
    
    updateStatusLabel()
    addRandomAnnotations()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    scrollView.refreshAnnotations()
    
    self.becomeFirstResponder()
  }
  
  @IBAction func addRandomAnnotations(_ sender: Any? = nil) {
    for _ in 1...5 {
      let annotation = DemoAnnotation()
      annotation.contentPosition = CGPoint(x:randomIntFrom(start: 0, to: Int(skippingGirlImageSize.width)),
                                           y: randomIntFrom(start: 0, to: Int(skippingGirlImageSize.height)))
      scrollView.add(annotation)
    }
  }
  
  func randomIntFrom(start: Int, to end: Int) -> Int {
    var a = start
    var b = end
    // swap to prevent negative integer crashes
    if a > b {
      swap(&a, &b)
    }
    return Int(arc4random_uniform(UInt32(b - a + 1))) + a
  }
  
  //MARK: Shake Gesture
  
  override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
    guard let event = event else { return }
    
    if (event.type == .motion && event.subtype == .motionShake) {
      scrollView.removeAllAnnotations()
    }
  }

  //MARK: TileSource
  
  func tiledScrollView(_ scrollView: JCTiledScrollView, imageForRow row: Int, column: Int, scale: Int) -> UIImage {
    return UIImage(named: "tiles/SkippingGirl_\(scale)x_\(row)_\(column).png")!
  }
  
  //MARK: Annotations
  
  func tiledScrollViewDidZoom(_ scrollView: JCTiledScrollView) {
    updateStatusLabel()
  }
  
  func tiledScrollView(_ scrollView: JCTiledScrollView, didReceiveSingleTap gestureRecognizer: UIGestureRecognizer) {
    let tapPoint = gestureRecognizer.location(in: scrollView.tiledView)
    
    //tap point on the tiledView does not inlcude the zoomScale applied by the scrollView
    self.statusLabel.text = String(format:"zoomScale: %0.2f, x: %0.0f y: %0.0f", scrollView.zoomScale, tapPoint.x, tapPoint.y)
  }
  
  func tiledScrollView(_ scrollView: JCTiledScrollView, viewFor annotation: JCAnnotation) -> JCAnnotationView {
    if let annotationView = scrollView.dequeueReusableAnnotationView(withReuseIdentifier: "ReuseIdentifier") {
      return annotationView
    }
    
    let annotationView = DemoAnnotationView(frame:.zero, annotation:annotation, reuseIdentifier: "ReuseIdentifier")
    annotationView.imageView?.image = UIImage(named:"marker-red.png")
    annotationView.sizeToFit()
    
    return annotationView
  }
  
  func updateStatusLabel() {
    self.statusLabel.text = String(format:"zoomScale: %0.2f", self.scrollView.zoomScale)
  }
}
