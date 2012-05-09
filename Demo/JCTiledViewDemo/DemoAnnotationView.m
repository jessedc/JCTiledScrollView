//
//  DemoAnnotationView.m
//  JCTiledViewDemo
//
//  Created by Jesse Collis on 10/05/12.
//  Copyright (c) 2012 JC Multimedia Design. All rights reserved.
//

#import "DemoAnnotationView.h"

@implementation DemoAnnotationView
@synthesize imageView = _imageView;

- (id)initWithAnnotation:(JCAnnotation *)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
  if ((self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]))
  {
    _imageView = [[UIImageView alloc] init];
    self.backgroundColor = [UIColor greenColor];
  }
  return self;
}

- (void)dealloc
{
  RELEASE(_imageView);
  [super dealloc];
}

- (CGSize)sizeThatFits:(CGSize)size
{
  return CGSizeMake(30, 30);
}

//- (void)layoutSubviews
//{
//  [_imageView sizeToFit];
//  _imageView.frame  = CGRectMake(0,0,CGRectGetWidth(_imageView.frame), CGRectGetHeight(_imageView.frame));
//}

@end
