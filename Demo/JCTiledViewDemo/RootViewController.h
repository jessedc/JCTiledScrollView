//
//  RootViewController.h
//  JCTiledViewDemo
//
//  Created by Jesse Collis
//  Copyright (c) 2012 JC Multimedia Design. All rights reserved.
//

#import "JCTiledScrollView.h"

@class DetailView, JCTiledScrollView;

@interface RootViewController : UIViewController <JCTileSource, JCTiledScrollViewDelegate>

@property (strong, nonatomic) JCTiledScrollView *scrollView;
@property (strong, nonatomic) DetailView *detailView;

@end
