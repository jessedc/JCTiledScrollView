//
//  JCTiledScrollView.m
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

#import "JCTiledScrollView.h"

@interface JCTiledScrollView ()
@property (nonatomic, retain) UIView *canvasView;
@property (nonatomic, retain) JCPDFTiledView *tiledView;
@end

@implementation JCTiledScrollView
@synthesize dataSource = dataSource_;
@synthesize tiledScrollViewDelegate = tiledScrollViewDelegate_;
@synthesize tiledView = tiledView_;
@synthesize levelsOfZoom = levelsOfZoom_;
@synthesize canvasView = canvasView_;
@synthesize levelsOfDetail = levelsOfDetail_;

- (id)initWithFrame:(CGRect)frame contentSize:(CGSize)contentSize
{
	if ((self = [super initWithFrame:frame]))
  {
    self.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    self.levelsOfZoom = 2;
    self.minimumZoomScale = 1.;
    self.delegate = self;
    self.backgroundColor = [UIColor whiteColor];
    self.contentSize = contentSize;
    self.bouncesZoom = YES;
    self.bounces = YES;

    CGRect canvas_frame = CGRectMake(0., 0., self.contentSize.width, self.contentSize.height);
    self.canvasView = [[[UIView alloc] initWithFrame:canvas_frame] autorelease];

    self.tiledView = [[[JCPDFTiledView alloc] initWithFrame:canvas_frame] autorelease];
    //self.tiledView.delegate = self;
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

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
  if ([self.tiledScrollViewDelegate respondsToSelector:@selector(tiledScrollViewDidZoom:)])
  {
    [self.tiledScrollViewDelegate tiledScrollViewDidZoom:self];
  }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  if ([self.tiledScrollViewDelegate respondsToSelector:@selector(tiledScrollViewDidScroll:)])
  {
    [self.tiledScrollViewDelegate tiledScrollViewDidScroll:self];
  }
}

#pragma mark - JCTiledScrollView

-(void)setLevelsOfZoom:(size_t)levelsOfZoom
{
  levelsOfZoom_ = levelsOfZoom;
  self.maximumZoomScale = (float)powf(2, MAX(0, levelsOfZoom));
}

- (void)setLevelsOfDetail:(size_t)levelsOfDetail
{
  if (levelsOfDetail == 1) NSLog(@"Note: Setting levelsOfDetail to 1 causes strange behaviour");

  levelsOfDetail_ = levelsOfDetail;
  [self.tiledView setNumberOfZoomLevels:levelsOfDetail];
}

- (void)setContentCenter:(CGPoint)center animated:(BOOL)animated
{
  CGPoint new_contentOffset;
  new_contentOffset.x = MAX(0, (center.x * self.zoomScale) - (self.bounds.size.width / 2.0f));
  new_contentOffset.y = MAX(0, (center.y * self.zoomScale) - (self.bounds.size.height / 2.0f));
  
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
