//
//  JCTiledView.m
//  
//  Created by Jesse Collis on 1/2/2012.
//  Copyright 2012 JC Multimedia Design. All rights reserved.
//

#import "JCTiledView.h"

@implementation JCTiledLayer

+ (CFTimeInterval)fadeDuration;
{
  return 0.08;
}

@end

static const CGFloat kDefaultTileSize = 256.;


@interface JCTiledView ()
-(void)annotateRect:(CGRect)rect;
@end

@implementation JCTiledView

@synthesize delegate = delegate_;

#pragma mark - Properties

+(Class)layerClass;
{
  return [JCTiledLayer class];
}

- (JCTiledLayer *)tiledLayer;
{
  return (JCTiledLayer *)self.layer;
}

- (id)initWithFrame:(CGRect)frame;
{
  if ((self = [super initWithFrame:frame]))
  {
    [self.tiledLayer setTileSize:CGSizeMake(kDefaultTileSize * self.tiledLayer.contentsScale, kDefaultTileSize * self.tiledLayer.contentsScale)];
    self.tiledLayer.levelsOfDetail  = 0;
    self.tiledLayer.levelsOfDetailBias  = 3;
  }

  return self;
}

- (void)drawRect:(CGRect)rect;
{
  CGContextRef c = UIGraphicsGetCurrentContext();

  CGSize tile_size = CGSizeApplyAffineTransform(self.tiledLayer.tileSize, CGAffineTransformMakeScale(1 / self.tiledLayer.contentsScale, 1 / self.tiledLayer.contentsScale));
  CGFloat scale = CGContextGetCTM(c).a / self.tiledLayer.contentsScale;

  NSInteger col = CGRectGetMinX(rect) * scale / tile_size.width;
  NSInteger row = CGRectGetMinY(rect) * scale / tile_size.height;

  //Retina devices will start at 50% and move through to 200%, non-retina will go from 25% -> 100%

  UIImage *image = [[self delegate] tiledView:self imageForRow:row column:col scale:scale];
  [image drawInRect:rect];
  
  [self annotateRect:rect];
}

-(void)annotateRect:(CGRect)rect;
{
  CGContextRef c = UIGraphicsGetCurrentContext();
  CGFloat scale = CGContextGetCTM(c).a / self.tiledLayer.contentsScale;

  [[UIColor redColor] set];
  CGContextSetLineWidth(c, 2 / scale);
  CGContextStrokeRect(c, rect);
}

@end
