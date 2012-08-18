//
//  DemoAnnotationView.m
//  JCTiledViewDemo
//
//  Created by Jesse Collis
//  Copyright (c) 2012 JC Multimedia Design. All rights reserved.
//

#import "DemoAnnotationView.h"

@implementation DemoAnnotationView

- (id)initWithFrame:(CGRect)frame annotation:(id<JCAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
  if ((self = [super initWithFrame:frame annotation:annotation reuseIdentifier:reuseIdentifier]))
  {
    _imageView = [[UIImageView alloc] init];
    [self addSubview:_imageView];
  }
  return self;
}

- (CGSize)sizeThatFits:(CGSize)size
{
  return CGSizeMake(MAX(_imageView.image.size.width,30.f), MAX(_imageView.image.size.height,30.f));
}

- (void)layoutSubviews
{
  [_imageView sizeToFit];
  _imageView.frame  = CGRectMake(0.f,0.f,CGRectGetWidth(_imageView.frame), CGRectGetHeight(_imageView.frame));
}

@end
