//
//  JCVisibleAnnotationTuple.h
//  JCTiledViewDemo
//
//  Created by Jesse Collis on 4/07/12.
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

#import <UIKit/UIKit.h>

@class JCAnnotationView;
@protocol JCAnnotation;

@interface JCVisibleAnnotationTuple : NSObject
@property (nonatomic, strong) id<JCAnnotation> annotation;
@property (nonatomic, strong) JCAnnotationView *view;

+ (JCVisibleAnnotationTuple *)instanceWithAnnotation:(id<JCAnnotation>)annotation view:(JCAnnotationView *)view;
- (id)initWithAnnotation:(id<JCAnnotation>)annotation view:(JCAnnotationView *)view;

@end

@interface NSSet (JCVisibleAnnotationTupleHelpers)

- (id)visibleAnnotationTupleForAnnotation:(id<JCAnnotation>)annotation;
- (id)visibleAnnotationTupleForView:(JCAnnotationView *)view;

@end
