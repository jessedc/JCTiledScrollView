#CATiledLayer
###Jesse Collis, Melbourne Cocoaheads, February 2012

### 1. Introduction to CATiled Layer
 * What it does, why since iOS4 it's a good option
 * You can use _drawRect:_, instead of drawLayer:inContext

### 2. Background of my experience with Tiled Views
 * Maps in my own Apps
 * WWDC 2009 Videos on Tiling ScrollViews helped produce the first working maps
 * Extending that to Retina Displays was easy by providing @2x images
 * Performance is average; it's obvious as it draws tiles while you scroll, and no caching
 * Since late 2010 I wanted to use CATiledLayer; even had code working that could support iOS 3 with the non thread safe code.
 * iOS 3 caused a number of problems supporting high resolution displays due to no _[CALayer contentsScale]_ properties and having to rely on checking for _[UIScreen screenScale]_
 * I couldn't get get it right. I was going round in circles, adjusting zoom scales, levelsOfDetail, etc etc. Failed to ask the right questions

### 3. Enter 2010/2011
 * WWDC 2010 scrollview talk mentioned CATiledLayer in an iOS4 context, but no retina display
 * My own requirements were not to have to provide @2x images, only one set of tiles
 * My understanding of CALayers and [CALayer contentsScale] and [UIView contentScaleFactor] were limited
  at best and I was still struggling to ask the right questions.

### 4. 2012 I worked it out. Here is the outcome

 * Explain CALayer, it's relationship to UIView and the bitmap store
 * look at contentScale, and the effect of being a subview of UIScrollView
 * UIScrollView works on an exponential scale.
 
### 5. Where to next? 
 * Replace UIImage tiles with vector, SVG drawing


####Notes

> When you create your CATiledLayer with a frame, add it to your view hierarchy that becomes it's @1x, and you work from there with the levelsOfDetail, and LevelsOfDetailBias

>The problem was, I didn't want to provide two sets of tiles.

>JCTiledLayer utilises a clever method of reusing standard resolution tiles to alleviate the need to provide @2x graphics for your Layer.

> good study in the CALayer subtlties

> we're pulling the contents scale out of it, letting it handle itself