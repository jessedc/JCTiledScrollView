//
//  JCTiledScrollView.m
//  
//  Created by Jesse Collis on 1/2/2012.
//  Copyright 2012 JC Multimedia Design. All rights reserved.
//

#import "JCTiledScrollView.h"

@interface JCTiledScrollView ()
@property (nonatomic, retain) UIView *canvasView;
@property (nonatomic, retain) JCTiledView *tiledView;
@end

@implementation JCTiledScrollView
@synthesize dataSource = dataSource_;
@synthesize tiledView = tiledView_;
@synthesize levelsOfZoom = levelsOfZoom_;
@synthesize canvasView = canvasView_;

- (id)initWithFrame:(CGRect)frame contentSize:(CGSize)contentSize
{
	if ((self = [super initWithFrame:frame]))
  {
    self.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    [self setLevelsOfZoom:2];
    self.minimumZoomScale = 1.;
    self.delegate = self;
    self.backgroundColor = [UIColor whiteColor];
    self.contentSize = contentSize;
    self.bouncesZoom = YES;
    self.bounces = YES;

    CGRect canvas_frame = CGRectMake(0., 0., self.contentSize.width, self.contentSize.height);
    self.canvasView = [[[UIView alloc] initWithFrame:canvas_frame] autorelease];

    self.tiledView = [[[JCTiledView alloc] initWithFrame:canvas_frame] autorelease];
    self.tiledView.delegate = self;
    [self.canvasView addSubview:self.tiledView];

    [self addSubview:self.canvasView];
	}

	return self;
}

-(void)dealloc
{	
  [tiledView_ release];
  tiledView_ = nil;

  [canvasView_ release];
  canvasView_ = nil;

	[super dealloc];
}

#pragma mark - UIScrolViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
  return self.canvasView;
}

#pragma mark - JCTiledScrollView

-(void)setLevelsOfZoom:(float)levelsOfZoom
{
  if (levelsOfZoom != levelsOfZoom_)
  {
    levelsOfZoom_ = levelsOfZoom;
    self.maximumZoomScale = powf(2, MAX(0, levelsOfZoom));
  }
}

- (void)setContentCenter:(CGPoint)center animated:(BOOL)animated
{
  CGPoint new_contentOffset;
  new_contentOffset.x = MAX(0, (center.x * self.zoomScale) - (self.bounds.size.width / 2));
  new_contentOffset.y = MAX(0, (center.y * self.zoomScale) - (self.bounds.size.height / 2));
  
  new_contentOffset.x = MIN(new_contentOffset.x, (self.contentSize.width - self.bounds.size.width));
  new_contentOffset.y = MIN(new_contentOffset.y, (self.contentSize.height - self.bounds.size.height));
  
  [self setContentOffset:new_contentOffset animated:animated];
}

#pragma mark - JCTileSource

-(UIImage *)tiledView:(JCTiledView *)tiledView imageForRow:(NSInteger)row column:(NSInteger)column scale:(NSInteger)scale
{
  return [self.dataSource tiledScrollView:self imageForRow:row column:column scale:scale];
}

@end
