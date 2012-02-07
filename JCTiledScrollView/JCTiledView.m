//
//  JCTiledView.m
//  
//  Created by Jesse Collis on 1/2/2012.
//  Copyright 2012 JC Multimedia Design. All rights reserved.
//

#import "JCTiledView.h"

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
-(void)annotateRect:(CGRect)rect;
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
    self.tiledLayer.levelsOfDetail = 0;
    [self setNumberOfZoomLevels:3];
  }

  return self;
}

- (void)setNumberOfZoomLevels:(size_t)levels
{
  self.tiledLayer.levelsOfDetailBias = levels;
}

- (size_t)numberOfZoomLevels
{
  return self.tiledLayer.levelsOfDetailBias;
}

- (void)drawRect:(CGRect)rect
{
  CGContextRef c = UIGraphicsGetCurrentContext();
  CGFloat scale = CGContextGetCTM(c).a / self.tiledLayer.contentsScale;

  NSInteger col = (CGRectGetMinX(rect) * scale) / self.tileSize.width;
  NSInteger row = (CGRectGetMinY(rect) * scale) / self.tileSize.height;

  UIImage *tile_image = [self.delegate tiledView:self imageForRow:row column:col scale:scale];
  [tile_image drawInRect:rect];
  
  [self annotateRect:rect];
}

-(void)annotateRect:(CGRect)rect
{
  CGContextRef c = UIGraphicsGetCurrentContext();
  CGFloat scale = CGContextGetCTM(c).a / self.tiledLayer.contentsScale;

  [[UIColor redColor] set];
  CGContextSetLineWidth(c, 2.0f / scale);
  CGContextStrokeRect(c, rect);
}

@end
