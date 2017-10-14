//
//  JCAnnotationView.m
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

//MARK: Private

- (void)adjustCenter
{
  self.center = CGPointMake(_position.x + _centerOffset.x, _position.y + _centerOffset.y);
}

@end
