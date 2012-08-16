//
//  JCTiledView.m
//  
//  Created by Jesse Collis on 1/2/2012.
//  Copyright (c) 2012, Jesse Collis JC Multimedia Design. <jesse@jcmultimedia.com.au>
//  All rights reserved.
//
//  * Redistribution and use in source and binary forms, with or without 
//   modification, are permitted provided that the following conditions are met:
//
//  * Redistributions of source code must retain the above copyright 
//   notice, this list of conditions and the following disclaimer.
//
//  * Redistributions in binary form must reproduce the above copyright 
//   notice, this list of conditions and the following disclaimer in the 
//   documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
//  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE 
//  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY 
//  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES 
//  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; 
//  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND 
//  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT 
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS 
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE
//

#import "JCTiledView.h"
#import "JCTiledLayer.h"
#import "math.h"

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
  [[NSString stringWithFormat:@" %0.0f", log2f(scale)] drawAtPoint:CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect)) withFont:[UIFont boldSystemFontOfSize:font_size]];

  [[UIColor redColor] set];
  CGContextSetLineWidth(ctx, line_width);
  CGContextStrokeRect(ctx, rect);
}

@end
