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

- (id)initWithFrame:(CGRect)frame annotation:(JCAnnotation *)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
  if ((self = [super initWithFrame:frame annotation:annotation reuseIdentifier:reuseIdentifier]))
  {
    _imageView = [[UIImageView alloc] init];
    [self addSubview:_imageView];
  }
  return self;
}

- (void)dealloc
{
  [_imageView release];
  [super dealloc];
}

- (CGSize)sizeThatFits:(CGSize)size
{
  return CGSizeMake(MAX(_imageView.image.size.width,30), MAX(_imageView.image.size.height,30));
}

- (void)layoutSubviews
{
  [_imageView sizeToFit];
  _imageView.frame  = CGRectMake(0,0,CGRectGetWidth(_imageView.frame), CGRectGetHeight(_imageView.frame));
}

@end
