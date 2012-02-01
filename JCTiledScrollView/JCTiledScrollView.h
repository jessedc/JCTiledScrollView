//
//  JCTiledScrollView.h
//  
//  Created by Jesse Collis on 1/2/2012.
//  Copyright 2012 JC Multimedia Design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCTiledView.h"

@class JCTiledScrollView;

@protocol JCTileSource <NSObject>
- (UIImage *)tiledScrollView:(JCTiledScrollView *)scrollView imageForRow:(NSInteger)row column:(NSInteger)column scale:(NSInteger)scale;
@end

@interface JCTiledScrollView : UIScrollView <UIScrollViewDelegate, JCTiledViewDelegate>

@property (nonatomic, assign) id <JCTileSource> dataSource;
@property (nonatomic, assign) float levelsOfZoom;
@property (nonatomic, assign) float levelsOfDetail;

- (id)initWithFrame:(CGRect)frame contentSize:(CGSize)contentSize;

- (void)setContentCenter:(CGPoint)center animated:(BOOL)animated;

@end
