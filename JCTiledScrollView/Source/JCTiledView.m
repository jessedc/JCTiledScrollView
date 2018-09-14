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

@synthesize tileSize = _tileSize;
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
    self.numberOfZoomLevels = 3;
    self.shouldAnnotateRect = NO;
    self.tileSize = CGSizeMake(kDefaultTileSize, kDefaultTileSize);
  }
  return self;
}

//MARK: Properties

- (JCTiledLayer *)tiledLayer
{
  JCTiledLayer * modifiedLayer = (JCTiledLayer *) self.layer;
  modifiedLayer.tileSize = self.tileSize;
  return modifiedLayer;
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
  NSInteger tileScale = (NSInteger) CGContextGetCTM(ctx).a;
  
  CGRect scaleRect = CGRectApplyAffineTransform(rect, CGAffineTransformMakeScale(tileScale, tileScale));

  NSInteger col = (NSInteger) round((CGRectGetMinX(scaleRect) / self.tileSize.width));
  NSInteger row = (NSInteger) round((CGRectGetMinY(scaleRect) / self.tileSize.height));
  
  UIImage *tileImage = [(id<JCTiledBitmapViewDelegate>)self.delegate tiledView:self imageForRow:row column:col scale:tileScale];
  if (tileImage != nil)
  {
    [tileImage drawInRect:rect];
  }

  if (self.shouldAnnotateRect)
  {
    [self annotateRect:rect inContext:ctx];
  }
}

// MARK: Debug

- (void)annotateRect:(CGRect)rect inContext:(CGContextRef)ctx
{
  CGFloat tileScale = CGContextGetCTM(ctx).a;
  
  CGRect scaleRect = CGRectApplyAffineTransform(rect, CGAffineTransformMakeScale(tileScale, tileScale));
  
  CGFloat col = (NSInteger) round((CGRectGetMinX(scaleRect) / self.tileSize.width));
  CGFloat row = (NSInteger) round((CGRectGetMinY(scaleRect) / self.tileSize.height));
  
  CGFloat line_width = 2.0f / tileScale;
  CGFloat font_size = 12.0f / tileScale;

  NSString *pointString = [NSString stringWithFormat:@"(%@x%@@%@)", @(col), @(row), @(CGContextGetCTM(ctx).a)];
  [pointString drawAtPoint:CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect)) withAttributes:@{
                                                                                                  NSFontAttributeName: [UIFont boldSystemFontOfSize:font_size],
                                                                                                  NSForegroundColorAttributeName: [UIColor whiteColor]
                                                                                                  }];
  [[UIColor redColor] set];
  CGContextSetLineWidth(ctx, line_width);
  CGContextStrokeRect(ctx, rect);
}

@end
