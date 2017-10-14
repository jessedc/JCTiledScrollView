//
//  JCTiledView.m
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

#import "JCTiledView.h"
#import "JCTiledLayer.h"
#include <tgmath.h>

static const CGFloat kDefaultTileSize = 256.0f;

@interface JCTiledView ()
- (JCTiledLayer *)tiledLayer;
@end

@implementation JCTiledView

@dynamic tileSize;
@synthesize delegate = _delegate;
@synthesize shouldAnnotateRect = _shouldAnnotateRect;

+ (Class)layerClass
{
  return [JCTiledLayer class];
}

- (id)initWithFrame:(CGRect)frame
{
  if (self = [super initWithFrame:frame])
  {
    CGSize scaledTileSize = CGSizeApplyAffineTransform(self.tileSize, CGAffineTransformMakeScale(self.contentScaleFactor, self.contentScaleFactor));
    self.tiledLayer.tileSize = scaledTileSize;
    self.tiledLayer.levelsOfDetail = 1;
    self.numberOfZoomLevels = 3;
    self.shouldAnnotateRect = NO;
  }
  return self;
}

#pragma mark - Properties

- (JCTiledLayer *)tiledLayer
{
  return (JCTiledLayer *)self.layer;
}

- (CGSize)tileSize
{
  return CGSizeMake(kDefaultTileSize, kDefaultTileSize);
}

- (size_t)numberOfZoomLevels
{
  return self.tiledLayer.levelsOfDetailBias;
}

- (void)setNumberOfZoomLevels:(size_t)levels
{
  self.tiledLayer.levelsOfDetailBias = levels;
}

- (void)drawRect:(CGRect)rect
{
  CGContextRef ctx = UIGraphicsGetCurrentContext();
  //FIXME: we get warnings because we're accessing self.layer from background threads here
  CGFloat scale = CGContextGetCTM(ctx).a / self.tiledLayer.contentsScale;

  NSInteger col = (NSInteger)((CGRectGetMinX(rect) * scale) / self.tileSize.width);
  NSInteger row = (NSInteger)((CGRectGetMinY(rect) * scale) / self.tileSize.height);

  UIImage *tile_image = [(id<JCTiledBitmapViewDelegate>)self.delegate tiledView:self imageForRow:row column:col scale:(NSInteger)scale];
  [tile_image drawInRect:rect];

  if (self.shouldAnnotateRect) [self annotateRect:rect inContext:ctx];
}

// Handy for Debug
- (void)annotateRect:(CGRect)rect inContext:(CGContextRef)ctx
{
  CGFloat scale = CGContextGetCTM(ctx).a / self.tiledLayer.contentsScale;
  CGFloat line_width = 2.0f / scale;
  CGFloat font_size = 16.0f / scale;

  [[UIColor whiteColor] set];
  
  NSString *pointString = [NSString stringWithFormat:@" %@", @(log2(scale))];
  [pointString drawAtPoint:CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect)) withAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:font_size]}];

  [[UIColor redColor] set];
  CGContextSetLineWidth(ctx, line_width);
  CGContextStrokeRect(ctx, rect);
}

@end
