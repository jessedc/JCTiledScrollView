//
//  JCTiledScrollView.h
//  
//  Created by Jesse Collis on 1/2/2012.
//
//  Copyright (c) 2012-2017 Jesse Collis <jesse@jcmultimedia.com.au>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

#import <UIKit/UIKit.h>

@class JCTiledScrollView, JCTiledView, JCAnnotationView, JCVisibleAnnotationTuple;
@protocol JCAnnotation;


@protocol JCTileSource <NSObject>
// The scale value is the pixel scale of the tile required, not the scale of the scroll view. On retina devices the tile scale will start at 2 etc.
- (UIImage * _Nullable)tiledScrollView:(JCTiledScrollView * _Nonnull)scrollView imageForRow:(NSInteger)row column:(NSInteger)column scale:(NSInteger)scale;
@end

NS_ASSUME_NONNULL_BEGIN
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
NS_ASSUME_NONNULL_END

@interface JCTiledScrollView : UIView <UIScrollViewDelegate>
{
  @private
  NSMutableSet *_recycledAnnotationViews;
  NSMutableSet *_annotations;
  NSMutableSet *_visibleAnnotations;
  JCVisibleAnnotationTuple *_previousSelectedAnnotationTuple;
  JCVisibleAnnotationTuple *_currentSelectedAnnotationTuple;
}

// Delegates
@property (nonatomic, weak, nullable) id <JCTiledScrollViewDelegate> tiledScrollViewDelegate;
@property (nonatomic, weak, nullable) id <JCTileSource> dataSource;

// Internals
@property (nonatomic, strong, nonnull) JCTiledView *tiledView;
@property (nonatomic, strong, nonnull) UIScrollView *scrollView;
@property (nonatomic, strong, nonnull) UIView *canvasView;

@property (nonatomic, assign) size_t levelsOfZoom;
@property (nonatomic, assign) size_t levelsOfDetail;
@property (nonatomic, assign) CGFloat zoomScale;

// Default gesture behvaiour
@property (nonatomic, assign) BOOL centerSingleTap;
@property (nonatomic, assign) BOOL zoomsInOnDoubleTap;
@property (nonatomic, assign) BOOL zoomsToTouchLocation;
@property (nonatomic, assign) BOOL zoomsOutOnTwoFingerTap;

+ (nonnull Class)tiledLayerClass;

- (nonnull instancetype)initWithFrame:(CGRect)frame contentSize:(CGSize)contentSize;

- (void)setContentCenter:(CGPoint)center animated:(BOOL)animated;
- (void)setZoomScale:(CGFloat)zoomScale animated:(BOOL)animated;

// Annotations
- (nullable JCAnnotationView *)dequeueReusableAnnotationViewWithReuseIdentifier:(nonnull NSString *)reuseIdentifier;
- (void)refreshAnnotations;

- (void)addAnnotation:(nonnull id<JCAnnotation>)annotation;
- (void)addAnnotations:(nonnull NSArray *)annotations;
- (void)removeAnnotation:(nonnull id<JCAnnotation>)annotation;
- (void)removeAnnotations:(nonnull NSArray *)annotations;
- (void)removeAllAnnotations;

@end
