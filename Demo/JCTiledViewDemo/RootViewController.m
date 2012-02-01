//
//  RootViewController.m
//  JCTiledViewDemo
//
//  Created by Jesse Collis on 1/02/12.
//  Copyright (c) 2012 JC Multimedia Design. All rights reserved.
//

#import "RootViewController.h"

#define SkippingGirlImageSize CGSizeMake(432., 648.)
#define SkippingGirlImageName @"SkippingGirl"

@implementation RootViewController

@synthesize scrollView = scrollView_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
{
  if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
  {
    
  }
  return self;
}

- (void)dealloc;
{
  [super dealloc];

  [scrollView_ release];
  scrollView_ = nil;
}


#pragma mark - View lifecycle

- (void)viewDidLoad;
{
  self.scrollView = [[JCTiledScrollView alloc] initWithFrame:self.view.frame contentSize:SkippingGirlImageSize];
  self.scrollView.dataSource = self;
  self.scrollView.levelsOfZoom = 4; // ^2
  self.scrollView.zoomScale = 1;
  
  [self.view addSubview:self.scrollView];
}

- (void)viewDidUnload;
{
  [super viewDidUnload];

  self.scrollView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;
{
  return YES;
}

#pragma mark - JCTileSource

- (UIImage *)tiledScrollView:(JCTiledScrollView *)scrollView imageForRow:(NSInteger)row column:(NSInteger)column scale:(NSInteger)scale;
{
 return [UIImage imageNamed:[NSString stringWithFormat:@"tiles/%@_%dx_%d_%d.png", SkippingGirlImageName, scale, row, column]]; 
}


@end
