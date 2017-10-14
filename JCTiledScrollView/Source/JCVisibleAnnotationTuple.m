//
//  JCVisibleAnnotationTuple.m
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

#import "JCVisibleAnnotationTuple.h"

@implementation JCVisibleAnnotationTuple
@synthesize annotation = _annotation;
@synthesize view = _view;

+ (JCVisibleAnnotationTuple *)instanceWithAnnotation:(id<JCAnnotation>)annotation view:(JCAnnotationView *)view
{
  return [[self alloc] initWithAnnotation:annotation view:view];
}

- (instancetype)initWithAnnotation:(id<JCAnnotation>)annotation view:(JCAnnotationView *)view
{
  if ((self = [super init]))
  {
    self.annotation = annotation;
    self.view = view;
  }
  return self;
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
