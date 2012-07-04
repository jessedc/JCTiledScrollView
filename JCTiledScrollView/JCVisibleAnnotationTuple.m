//
//  JCVisibleAnnotationTuple.m
//  JCTiledViewDemo
//
//  Created by Jesse Collis on 4/07/12.
//  Copyright (c) 2012 JC Multimedia Design. All rights reserved.
//

#import "JCVisibleAnnotationTuple.h"

@implementation JCVisibleAnnotationTuple
@synthesize annotation = _annotation;
@synthesize view = _view;

+ (JCVisibleAnnotationTuple *)instanceWithAnnotation:(id<JCAnnotation>)annotation view:(JCAnnotationView *)view
{
  return [[[self alloc] initWithAnnotation:annotation view:view] autorelease];
}

- (id)initWithAnnotation:(id<JCAnnotation>)annotation view:(JCAnnotationView *)view
{
  if ((self = [super init]))
  {
    self.annotation = annotation;
    self.view = view;
  }
  return self;
}

- (void)dealloc
{
  _annotation = nil;
  _view = nil;

  [super dealloc];
}

@end

@implementation NSSet (JCVisibleAnnotationTupleHelpers)

- (id)visibleAnnotationTupleForAnnotation:(id<JCAnnotation>)annotation
{
  for (JCVisibleAnnotationTuple *t in self)
  {
    if (t.annotation == annotation)
    {
      return t;
    }
  }
  return nil;
}

- (id)visibleAnnotationTupleForView:(JCAnnotationView *)view
{
  for (JCVisibleAnnotationTuple *t in self)
  {
    if (t.view == view)
    {
      return t;
    }
  }
  return nil;
}

@end
