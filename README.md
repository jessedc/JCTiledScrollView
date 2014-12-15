# JCTiledScrollView

by Jesse Collis

  * [Visit JCMultimedia.com.au][2]
  * [Follow @sirjec on Twitter][3]
  * Checkout the presentation I did on CATiledLayer [Here][17]

## About JCTiledScrollView

JCTiledScrollView is a set of classes that wrap UIScrollView and CATiledLayer. The project to simplify displaying large images and PDFs at multiple zoom scales. As the project evolves it's moving towards becoming a fully featured custom map view replacement with gestures and annotations.

Feature requests and pull-requests are most welcome.

## Features

 * Display tiled bitmap images and single page PDFs with two separate classes
 * Supports standard and high resolution displays
 * You only need to provide one set of bitmap tiles; no need for @2x tiles
 * A handy set of default UIGestureRecognizer actions and delegate callbacks
 * Annotation support with an interface similar to MKMapView
 * Demo code, example PNG tiles and PDF file included
 * Supports iOS 4.0+

<img src="https://github.com/jessedc/JCTiledScrollView/raw/master/Demo/JCTiledViewDemo.png" alt="Skipping Girl JCTiledScrollView Demo" width="206" style="width:206px;"/>
<img src="https://github.com/jessedc/JCTiledScrollView/raw/master/Demo/JCTiledViewDemo2.png" alt="PDF Rendering in JCTiledScrollView Demo" width="206" style="width:206px;"/>

## Latest Updates

### December 2014
  * Added a demo project written in Swift

### April 2013
  * Moved to ARC

### August 2012
  * You can drag annotations around over at the [drag-annotations branch][16]. This will come into master very soon
  * JCTiledSCrollView is now packaged as a Static library within a workspace

### July 2012
  * Updated source and demo to be compatible with Xcode's ARC refactor tool
  * JCTiledScrollView is now provided as a static library

### May 2012
  * Annotation support

### March 2012
  * Merged experimental PDF rendering classes into the main project. Welcome JCTiledPDFScrollView.
  * Added an initial set of UIGestureRecognizers with some optional default behaviour, similar to MKMapView

### Next Steps

 * Zooming in both directions
 * Annotation selection
 * Advanced UIGestureRecognizers (dragging overlays etc)
 * Provide as a static library
 

### Handy Links
 * Cut your large images into tiles with [Tile-Cutter][5] by [Jeff La Marche][6]
 * Cut your images on the command line with [my fork][12] of [Chris Miles'][13] experimental [SliceTool][12] program
 * Shrink your bitmap tiles with [Image Optim][14]. It can half your tile size and [improve performance greatly][15]

### Further Reading
  * [Subduing CATiledLayer][9] by Matt Long (Cocoa is my Girlfriend)
  * Apple Tech-Note [Thread Safe UIKit Drawing][7] (in iOS 4+)  mentioned at WWDC 2010
  * Tread safe objects in iOS4 _UIGraphicsGetCurrentContext, UIImage, UIColor, UIFont_
  * Apple Documentation on [Supporting High Resolution Screens][8]
  * Apple's [View Programming Guide for iOS][10]
  * WWDC 2010 Session 104 - Designing Apps with ScrollViews
  * WWDC 2011 Session 104 - Advanced Scroll View Techniques
  * [My presentation][17] on CATiledLayer and JCTiledScrollView at Melbourne Cocoaheads

### Project Background

Initially created as an open source project for the February 2012 [Melbourne Cocoaheads][4] meeting.

Created by Jesse Collis <jesse@jmcultimedia.com.au>, [@sirjec][3], [JC Multimedia Design][2].

### Licence

The "Skipping Girl" image is copyright (c) 2012, Jesse Collis and licensed under a [Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License][1].

The JCTiledScrollView code is copyright (c) 2012, Jesse Collis <jesse@jcmultimedia.com.au> and licenced under [Creative Commons Attribution 4.0](http://creativecommons.org/licenses/by/4.0/)


[1]: http://creativecommons.org/licenses/by-nc-sa/3.0/ "Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License"
[2]: http://jcmultimedia.com.au/ "JC Multimedia Design"
[3]: http://twitter.com/sirjec/ "@sirjec on Twitter"
[4]: http://www.melbournecocoaheads.com/ "Melbourne Cocoaheads"
[5]: https://github.com/jlamarche/Tile-Cutter "Tile-Cutter"
[6]: http://iphonedevelopment.blogspot.com/ "iPhone Development.blogspot.com"
[7]: https://developer.apple.com/library/ios/#qa/qa1637/_index.html "Thread Safe UIKit Drawing"
[8]: https://developer.apple.com/library/ios/#documentation/2DDrawing/Conceptual/DrawingPrintingiOS/SupportingHiResScreens/SupportingHiResScreens.html "Supporting High Resolution Screens"
[9]: http://www.cimgf.com/2011/03/01/subduing-catiledlayer/ "Subduing CATiledLayer on Cocoa Is My Girlfriend"
[10]: https://developer.apple.com/library/ios/documentation/WindowsViews/Conceptual/ViewPG_iPhoneOS/WindowsandViews/WindowsandViews.html#//apple_ref/doc/uid/TP40009503-CH2-SW1 "View Programming Guide for iOS - View and Window Architecture"
[11]: https://github.com/jessedc/JCTiledScrollView/tree/pdf-experimental "JCTiledView - Experimental PDF branch"
[12]: https://github.com/jessedc/SliceTool "jessedc's fork of SliceTool on github"
[13]: https://github.com/chrismiles/SliceTool "Chris Miles' SliceTool on github"
[14]: http://imageoptim.com "Image Optim"
[15]: http://imageoptim.com/tweetbot.html "Image Optim Case study: Tweetbot for iPad"
[16]: https://github.com/jessedc/JCTiledScrollView/tree/drag-annotations "JCTiledScrollView drag-annotations branch"
[17]: https://github.com/jessedc/JCTiledScrollView/blob/master/Cocoheads/talk_outline.md "JCTiledScrollView introduced at Melbourne Cocoaheads February 2012"
