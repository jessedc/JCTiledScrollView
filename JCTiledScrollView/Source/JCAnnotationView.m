//
//  JCAnnotationView.m
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
//

#import "JCAnnotationView.h"
#import "JCAnnotation.h"

@implementation JCAnnotationView
@synthesize annotation = _annotation;
@synthesize position = _position;
@synthesize centerOffset = _centerOffset;
@synthesize reuseIdentifier = _reuseIdentifier;

- (id)initWithFrame:(CGRect)frame annotation:(id<JCAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
  if ((self = [super initWithFrame:frame]))
  {
    _centerOffset = CGPointZero;
    _position = CGPointZero;
    _annotation = annotation;
    _reuseIdentifier = reuseIdentifier;
  }
  return self;
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
