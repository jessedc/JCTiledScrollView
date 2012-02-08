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
#import "math.h"

static const CFTimeInterval kDefaultFadeDuration = 0.08;

@implementation JCTiledLayer

+ (CFTimeInterval)fadeDuration
{
  return kDefaultFadeDuration;
}

@end

static const CGFloat kDefaultTileSize = 256.0f;

@interface JCTiledView ()
@property (nonatomic, assign) CGSize tileSize;
@property (nonatomic, assign) CGSize scaledTileSize;
-(void)annotateRect:(CGRect)rect inContext:(CGContextRef)ctx;
@end

@implementation JCTiledView

@synthesize delegate = delegate_;
@synthesize tileSize = tileSize_;
@synthesize scaledTileSize = scaledTileSize_;

#pragma mark - Properties

+(Class)layerClass
{
  return [JCTiledLayer class];
}

- (JCTiledLayer *)tiledLayer
{
  return (JCTiledLayer *)self.layer;
}

- (id)initWithFrame:(CGRect)frame
{
  if ((self = [super initWithFrame:frame]))
  {
    self.tileSize = CGSizeMake(kDefaultTileSize, kDefaultTileSize);
    self.scaledTileSize = CGSizeApplyAffineTransform(self.tileSize, CGAffineTransformMakeScale(self.contentScaleFactor, self.contentScaleFactor));

    self.tiledLayer.tileSize = self.scaledTileSize;
    self.tiledLayer.levelsOfDetail = 1;
    [self setNumberOfZoomLevels:3];
  }

  return self;
}

- (void)setNumberOfZoomLevels:(size_t)levels
{
  NSAssert(!(levels == 1 && self.tiledLayer.levelsOfDetail == 1), @"There is a strange edge case when levelsOfDetail and levelsOfDetailBias are both 1.");
  
  self.tiledLayer.levelsOfDetailBias = levels;
}

- (size_t)numberOfZoomLevels
{
  return self.tiledLayer.levelsOfDetailBias;
}

- (void)drawRect:(CGRect)rect
{
  CGContextRef ctx = UIGraphicsGetCurrentContext();
  CGFloat scale = CGContextGetCTM(ctx).a / self.tiledLayer.contentsScale;

  NSInteger col = (CGRectGetMinX(rect) * scale) / self.tileSize.width;
  NSInteger row = (CGRectGetMinY(rect) * scale) / self.tileSize.height;

  UIImage *tile_image = [self.delegate tiledView:self imageForRow:row column:col scale:scale];
  [tile_image drawInRect:rect];
  
  [self annotateRect:rect inContext:ctx];
}

-(void)annotateRect:(CGRect)rect inContext:(CGContextRef)ctx
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
