//
//  ADAnnotationTapGestureRecognizer.h
//  JCTiledScrollView
//
//  Created by Anthony DAMOTTE on 02/11/12.
//  Copyright (c) 2012 Orange Business Services IT&Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JCVisibleAnnotationTuple;

@interface ADAnnotationTapGestureRecognizer : UITapGestureRecognizer
@property (nonatomic, strong) JCVisibleAnnotationTuple *tapAnnotation;
@end
