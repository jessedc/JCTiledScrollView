//
//  JCAnnotationView.m
//
//  Created by Jesse Collis on 9/05/12.
//  Copyright (c) 2012 JC Multimedia Design. All rights reserved.
//

#import "JCAnnotationView.h"
#import "JCAnnotation.h"

@implementation JCAnnotationView
@synthesize annotation = _annotation;
@synthesize position = _position;
@synthesize centerOffset = _centerOffset;

- (id)initWithAnnotation:(JCAnnotation *)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
  if ((self = [super initWithFrame:CGRectZero]))
  {
    _centerOffset = CGPointZero;
    _position = CGPointZero;
    _annotation = [annotation retain];
  }
  return self;
}

- (void)dealloc
{
  RELEASE(_annotation);
  [super dealloc];
}


- (void)setPosition:(CGPoint)position
{
  if (!CGPointEqualToPoint(_position, position))
  {
    _position = position;
    [self adjustCenter];
  }
}

- (void)setCenterOffset:(CGPoint)centerOffset
{
  if (!CGPointEqualToPoint(_centerOffset, centerOffset))
  {
    _centerOffset = centerOffset;
    [self adjustCenter];
  }
}

#pragma mark - Private

- (void)adjustCenter
{
  self.center = CGPointMake(_position.x + _centerOffset.x, _position.y + _centerOffset.y);
}

@end
