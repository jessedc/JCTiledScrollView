//
//  JCTiledScrollView.h
//  
//  Created by Jesse Collis on 1/2/2012.
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

@class JCTiledScrollView, JCTiledView, JCAnnotationView, JCVisibleAnnotationTuple;
@protocol JCAnnotation;

@protocol JCTileSource <NSObject>
- (UIImage *)tiledScrollView:(JCTiledScrollView *)scrollView imageForRow:(NSInteger)row column:(NSInteger)column scale:(NSInteger)scale;
@end

@protocol JCTiledScrollViewDelegate <NSObject>

- (JCAnnotationView *)tiledScrollView:(JCTiledScrollView *)scrollView viewForAnnotation:(id<JCAnnotation>)annotation;

@optional
- (void)tiledScrollViewDidZoom:(JCTiledScrollView *)scrollView;
- (void)tiledScrollViewDidScroll:(JCTiledScrollView *)scrollView;

@optional
- (void)tiledScrollView:(JCTiledScrollView *)scrollView annotationWillDisappear:(id<JCAnnotation>)annotation;
- (void)tiledScrollView:(JCTiledScrollView *)scrollView annotationDidDisappear:(id<JCAnnotation>)annotation;
- (void)tiledScrollView:(JCTiledScrollView *)scrollView annotationWillAppear:(id<JCAnnotation>)annotation;
- (void)tiledScrollView:(JCTiledScrollView *)scrollView annotationDidAppear:(id<JCAnnotation>)annotation;
- (void)tiledScrollView:(JCTiledScrollView *)scrollView didSelectAnnotationView:(JCAnnotationView *)view;
- (void)tiledScrollView:(JCTiledScrollView *)scrollView didDeselectAnnotationView:(JCAnnotationView *)view;

- (void)tiledScrollView:(JCTiledScrollView *)scrollView didReceiveSingleTap:(UIGestureRecognizer *)gestureRecognizer;
- (void)tiledScrollView:(JCTiledScrollView *)scrollView didReceiveDoubleTap:(UIGestureRecognizer *)gestureRecognizer;
- (void)tiledScrollView:(JCTiledScrollView *)scrollView didReceiveTwoFingerTap:(UIGestureRecognizer *)gestureRecognizer;

@end

@interface JCTiledScrollView : UIView <UIScrollViewDelegate>
{
  @private
  NSMutableSet *_recycledAnnotationViews;
  NSMutableSet *_annotations;
  NSMutableSet *_visibleAnnotations;
  JCVisibleAnnotationTuple *_previousSelectedAnnotationTuple;
  JCVisibleAnnotationTuple *_currentSelectedAnnotationTuple;
}

//Delegates
@property (nonatomic, weak) id <JCTiledScrollViewDelegate> tiledScrollViewDelegate;
@property (nonatomic, weak) id <JCTileSource> dataSource;

//internals
@property (nonatomic, strong) JCTiledView *tiledView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *canvasView;

@property (nonatomic, assign) size_t levelsOfZoom;
@property (nonatomic, assign) size_t levelsOfDetail;

@property (nonatomic, assign) float zoomScale;
- (void)setZoomScale:(float)zoomScale animated:(BOOL)animated;

//Default gesture behvaiour
@property (nonatomic, assign) BOOL centerSingleTap;
@property (nonatomic, assign) BOOL zoomsInOnDoubleTap;
@property (nonatomic, assign) BOOL zoomsToTouchLocation;
@property (nonatomic, assign) BOOL zoomsOutOnTwoFingerTap;

+ (Class)tiledLayerClass;

- (id)initWithFrame:(CGRect)frame contentSize:(CGSize)contentSize;

- (void)setContentCenter:(CGPoint)center animated:(BOOL)animated;


//Annotations
- (JCAnnotationView *)dequeueReusableAnnotationViewWithReuseIdentifier:(NSString *)reuseIdentifier;
- (void)refreshAnnotations;

- (void)addAnnotation:(id<JCAnnotation>)annotation;
- (void)addAnnotations:(NSArray *)annotations;
- (void)removeAnnotation:(id<JCAnnotation>)annotation;
- (void)removeAnnotations:(NSArray *)annotations;
- (void)removeAllAnnotations;

@end
