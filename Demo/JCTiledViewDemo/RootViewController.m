//
//  RootViewController.m
//  JCTiledViewDemo
//
//  Created by Jesse Collis on 1/02/12.
//  Copyright (c) 2012 JC Multimedia Design. All rights reserved.
//

#import "RootViewController.h"
#import "JCTiledPDFScrollView.h"

#define SkippingGirlImageSize CGSizeMake(432., 648.)
#define CityMetroMapSize CGSizeMake(800., 600.)
#define SkippingGirlImageName @"SkippingGirl"

@implementation RootViewController

@synthesize scrollView = scrollView_;
@synthesize detailView = detailView_;

- (void)dealloc
{
  [scrollView_ release];
  scrollView_ = nil;

  [detailView_ release];
  detailView_ = nil;
  
  [super dealloc];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
  self.detailView = [[[DetailView alloc] initWithFrame:CGRectZero] autorelease];
  self.detailView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  CGSize size_for_detail = [self.detailView sizeThatFits:self.view.bounds.size];
  [self.detailView setFrame:CGRectMake(0,0,size_for_detail.width, size_for_detail.height)];
  [self.view addSubview:self.detailView];
  
  CGRect scrollView_frame = CGRectOffset(CGRectInset(self.view.bounds,0.,size_for_detail.height/2.0f),0.,size_for_detail.height/2.0f);
  
  //PDF
  self.scrollView = [[[JCTiledPDFScrollView alloc] initWithFrame:scrollView_frame URL:[[NSBundle mainBundle] URLForResource:@"Map" withExtension:@"pdf"]] autorelease];
  
  //Bitmap
  //self.scrollView = [[[JCTiledScrollView alloc] initWithFrame:scrollView_frame contentSize:SkippingGirlImageSize] autorelease];
  //self.scrollView.dataSource = self;
  //self.scrollView.tiledScrollViewDelegate = self;

  self.scrollView.zoomScale = 1.0f;

  // totals 4 sets of tiles across all devices, retina devices will miss out on the first 1x set
  self.scrollView.levelsOfZoom = 3;
  self.scrollView.levelsOfDetail = 3;
  
  [self.view addSubview:self.scrollView];
}

- (void)viewDidUnload
{
  [super viewDidUnload];

  self.scrollView = nil;
  self.detailView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return YES;
}

#pragma mark - UIScrollViewDelegate

- (void)tiledScrollViewDidZoom:(JCTiledScrollView *)scrollView
{
  self.detailView.textLabel.text = [NSString stringWithFormat:@"zoomScale: %0.2f", scrollView.zoomScale];
}

#pragma mark - JCTileSource

- (UIImage *)tiledScrollView:(JCTiledScrollView *)scrollView imageForRow:(NSInteger)row column:(NSInteger)column scale:(NSInteger)scale
{
 return [UIImage imageNamed:[NSString stringWithFormat:@"tiles/%@_%dx_%d_%d.png", SkippingGirlImageName, scale, row, column]]; 
}


@end
