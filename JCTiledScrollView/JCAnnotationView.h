//
//  JCAnnotationView.h
//
//  Created by Jesse Collis on 9/05/12.
//  Copyright (c) 2012 JC Multimedia Design. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JCAnnotation;

@interface JCAnnotationView : UIView

@property (nonatomic, retain) JCAnnotation *annotation;
@property (nonatomic, assign) CGPoint position;
@property (nonatomic, assign) CGPoint centerOffset;
@property (nonatomic, retain) NSString *reuseIdentifier;

- (id)initWithAnnotation:(JCAnnotation *)annotation reuseIdentifier:(NSString *)reuseIdentifier;

@end
