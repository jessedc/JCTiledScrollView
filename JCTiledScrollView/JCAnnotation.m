//
//  JCAnnotation.m
//  JCTiledViewDemo
//
//  Created by Jesse Collis on 9/05/12.
//  Copyright (c) 2012 JC Multimedia Design. All rights reserved.
//

#import "JCAnnotation.h"
#import "JCAnnotationView.h"

@implementation JCAnnotation
@synthesize contentPosition = _contentPosition;
@synthesize screenPosition = _screenPosition;
@synthesize view = _view;

- (id)init
{
  if ((self = [super init]))
  {
    _view = nil;
    _screenPosition = CGPointZero;
    _contentPosition = CGPointZero;
  }
  return self;
}

- (void)dealloc
{
  RELEASE(_view);
  [super dealloc];
}

- (BOOL)isWithinBounds:(CGRect)bounds
{
  return CGRectContainsPoint(bounds, self.screenPosition);
}

- (void)setScreenPosition:(CGPoint)screenPosition
{
  if (!CGPointEqualToPoint(_screenPosition, screenPosition))
  {
    _screenPosition = screenPosition;

    if (nil != _view)
    {
      _view.position = screenPosition;
    }
  }
}

- (void)setView:(JCAnnotationView *)view
{
  if (view != _view)
  {
    [_view removeFromSuperview];
    RELEASE(_view);
  }
  if (nil != view)
  {
    _view = [view retain];
    _view.annotation = self;
    _view.position = self.screenPosition;
  }
}

@end
