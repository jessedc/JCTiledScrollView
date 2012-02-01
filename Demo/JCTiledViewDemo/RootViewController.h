//
//  RootViewController.h
//  JCTiledViewDemo
//
//  Created by Jesse Collis on 1/02/12.
//  Copyright (c) 2012 JC Multimedia Design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCTiledScrollView.h"

@interface RootViewController : UIViewController <JCTileSource>

@property (nonatomic, retain) JCTiledScrollView *scrollView;


@end
