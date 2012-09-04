#CATiledLayer
###Jesse Collis, Melbourne Cocoaheads, February 2012

###Video of this presentation

Video of this presentation has been posted on Vimeo [here](https://vimeo.com/45293931)

### 1. Introduction to CATiled Layer
 * Who's used it before?
 * It draws large images at multiple zoom levels, and gives you asynchronous call backs as it needs a new tile at a new level
 * It caches the results, so you only get your drawRect: calls once, it then handles the rest
 * It's interface on iOS was improved in iOS 4. You can use _drawRect:_, instead of drawLayer:inContext. Much nicer to deal with

### 2. My experiences with Tiled Views goes back to 2009
 * Maps in my own Apps
 * WWDC 2009 Videos on Tiling ScrollViews helped produce the first working maps
 * Extending that to Retina displays in 2010 was easy by providing @2x images
 * Performance is average; it's obvious as it draws tiles while you scroll, provides no caching
 * Since late 2010 I wanted to use CATiledLayer; even had code working that nearly worked 100% including support for iOS 3 with the non thread safe code.
 * Insisting on iOS 3 compatibility caused a number of problems supporting high resolution displays without _[CALayer contentsScale]_ and having to check for _[UIScreen screenScale]_
 * I just **couldn't** get it right. I was going round in circles, adjusting zoom scales, levelsOfDetail.

### 3. My Introduction to CATiledLayer
 * WWDC 2010 scroll view talk mentioned CATiledLayer in an iOS4 context, but no retina display details
 * My understanding of CALayers and [CALayer contentsScale] and [UIView contentScaleFactor] were severely limited
 * Most CATiledLayer info was OSX, or PDF related and just didn't solve my immediate issue
 * I was struggling to ask the right questions
 * First demo project created in 2010, but just couldn't get it right


#### Main goals of the CATiledLayer project
 * CATiledLayer in a scrollView with programable zoom levels
 * Seamless integration into iOS4+
 * Seamless integration between retina / non-retina screens
 * Provide only one sized tile (not @2x)

### 4. Finally, in late 2011 I worked it out

> I'll try and give as much insight as possible, but most of this is based on my trial, error and reflection rather than a 100% understanding of everything. Most of my issues revolved around using the Apple Demo code as an example, rather than actually understanding it from the ground up.

 * Everyone is always saying each UIView is backed by a CALayer
 * All good CALayer documentation and the main Core Animation Programming Guide is OSX based
 * NSView is not CALayer backed, so if you're starting with no idea, this difference can mean a lot
 * The missing piece is that the _drawRect:_ method on a UIView subclass is essentially the same as it's underlying CALayer's delegate callback _drawLayer:inContext:_ that all the documentation talks about
 * A CALayer's _contentsScale_ property is set on creation by it's accompanying UIView in iOS
 * UIView/CoreGraphics handles _contentsScale_ and _contentScaleFactor_  for you **most** of the time (see Retina display)
 * CATiledLayer is just a CALayer subclass that's instantiated as a UIView's layer; it uses _drawRect:_ and _contentScale_ is the same as it's UIView
 * Although I had no specific examples at this point, the pieces started to come together.

#### A basic CATiledLayer UIView subclass implementation

    +(Class)layerClass
    {
      return [CATiledLayer class];
    }

    - (id)initWithFrame:(CGRect)frame
    {
      ...
      [(CATiledLayer *)self.layer setLevelsOfDetail:1];
      [(CATiledLayer *)self.layer setLevelsOfDetailBias:3];
      ...
    }

    - (void)drawRect:(CGRect)rect
    {
      CGContextRef c = UIGraphicsGetCurrentContext();
      CGFloat scale = CGContextGetCTM(c).a;

      NSInteger col = (CGRectGetMinX(rect) * scale) / self.tileSize.width;
      NSInteger row = (CGRectGetMinY(rect) * scale) / self.tileSize.height;

      UIImage *tile_image = [self.tileSource tiledView:self 
                                           imageForRow:row 
                                                column:col 
                                                 scale:scale];
      [tile_image drawInRect:rect];
    }


### 5. levelsOfDetail (LOD) and levelsOfDetailBias (LODB)

 * LOD is the number of levels CATiledLayer will ask you for as you **zoom out**. (defaults to 1)
 * LODB is the number of levels it will use as you **zoom in** (defaults to 0)

#### UIScrollView zoomScale vs. CATiledLayer LODB

 * UIScrollView's zoom scale works on a linear scale, but each LODB from CATiledLayer (or LOD) is a power of two more or less than the previous level of detail. 
 * You'll get a new LODB on each UIScrollView zoomScale that's a power of two.

 <table>
   <tr><th>UIScrollView zoomScale</th><th>CATIledLayer LODB</th><th>CATIledLayer LOD</th></tr>
   <tr><td>0.125</td><td>-</td><td>3</td></tr>
   <tr><td>0.25</td><td>-</td><td>2</td></tr>
   <tr><td>0.5</td><td>-</td><td>1</td></tr>
   <tr><td>1.0</td><td>0</td><td>0</td></tr>
   <tr><td>2.0</td><td>1</td><td>-</td></tr>
   <tr><td>4.0</td><td>2</td><td>-</td></tr>
   <tr><td>8.0</td><td>3</td><td>-</td></tr>
  </table>
  
  * If you set your LODB to 2 and your UIScrollView's zoomScale is at 8, then you'll only see up to the second level.

#### Things to note
   * Setting LOD and LODB to 0 causes a blank view
   * Setting LOD and LODB  to 1 seems to be undefined behaviour
   * Setting LOD to 1, and LODB > 1 is fine, but I like to set LOD to 0 if I'm using LODB.
   * Default value for LODB is 0

#### CATiledLayer UIView subclass implementation demo with UIScrollView wrapper
> Go go gadget demo

 * Show the effect of changing the LODB

#### Retina Display

> Running the code without any compensation for _contentsScale_ shows interesting results. There are obviously four times as many tiles. We can do better.

 Apple's docs on [Supporting High Resolution screens][1]:
 
> [You] may need to adjust [Core Animation Layers] drawing code to account for scale factors. Normally, when you draw in your view’s _drawRect:_ method ... of the layer’s delegate, the system automatically adjusts the graphics context to account for scale factors. **However**, knowing or changing that scale factor might still be necessary when your view does one of the following:

> * Creates additional Core Animation layers with **different scale factors** and composites them into its own content.

> Because of the _contentsScale_ value is 2, everything in pixel land is squared. Lets do that to our pixel values.
 
 * Multiply the _tileSize_ width and height by the contentsScale. (It's a pixel value).
 * Multiply the _rect_ passed to _drawRect:_ by the graphics CTM scale gives us our 512x512 size again.
 * **but** out tiles are 256, so divide that by the contentsScale to give us the tile in 256x256 dimensions.
 * _rect_ is now useful to find the right tile and draw it into the original rect and let coreGraphics scale it.

> It's clear at this point that we're looking more like normal tiled UIViews with @2x graphics, and we've even skipped the first _0_ LODB that we get on the standard resolution devices. 

### 6. What's next? 
 * JCTiledScrollView is my wrapper class around UIScrollView and is up on GitHub
 * Add gesture recognisers and overlay support (show metro editor)
 * Replace UIImage tiles with vector SVG drawing

### 7. Handy Tips

  * _[UIImage imageNamed:@"directory/image.png"]_ can be look inside directories and will also look inside .lproj directories. 
  * Localised assets (maps) are awesome if you have international apps. 
  * Xcode doesn't handle localised assets very well; You can manually add your tiles to your bundle's .lproj's if you are handy with scripting.
  * Cut your large images of various sizes into tiles with [Tile-Cutter][2] by Jeff La Marche.

[1]: https://developer.apple.com/library/ios/#documentation/2DDrawing/Conceptual/DrawingPrintingiOS/SupportingHiResScreens/SupportingHiResScreens.html "Supporting High Resolution Screens"
[2]: https://github.com/jlamarche/Tile-Cutter "Tile-Cutter"