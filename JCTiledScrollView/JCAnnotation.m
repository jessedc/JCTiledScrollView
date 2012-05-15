//
//  JCAnnotation.m
//
//  Created by Jesse Collis on 9/05/12.
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
  return CGRectContainsPoint(CGRectInset(bounds, -25.0f, -25.0f), self.screenPosition);
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
  
    if (nil != view)
    {
      _view = [view retain];
      _view.annotation = self;
      _view.position = self.screenPosition;
    }
  }
}

@end
