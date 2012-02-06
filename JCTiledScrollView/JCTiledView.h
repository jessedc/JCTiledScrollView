//
//  JCTiledView.h
//  
//  Created by Jesse Collis on 1/2/2012.
//  Copyright 2012 JC Multimedia Design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class JCTiledView;

@protocol JCTiledViewDelegate
-(UIImage *)tiledView:(JCTiledView *)tiledView imageForRow:(NSInteger)row column:(NSInteger)column scale:(NSInteger)scale;
@end

@interface JCTiledLayer : CATiledLayer
@end

@interface JCTiledView : UIView

@property (nonatomic, assign) id<JCTiledViewDelegate> delegate;
@property (nonatomic, assign) size_t numberOfZoomLevels;

- (JCTiledLayer *)tiledLayer;

@end
