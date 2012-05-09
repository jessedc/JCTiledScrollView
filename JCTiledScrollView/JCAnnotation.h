//
//  JCAnnotation.h
//  JCTiledViewDemo
//
//  Created by Jesse Collis on 9/05/12.
//  Copyright (c) 2012 JC Multimedia Design. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JCAnnotationView;

@interface JCAnnotation : NSObject

@property (nonatomic, assign) CGPoint contentPosition;
@property (nonatomic, assign) CGPoint screenPosition;
@property (nonatomic, retain) JCAnnotationView *view;

@end
