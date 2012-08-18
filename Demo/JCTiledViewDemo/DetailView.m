//
//  DetailView.m
//  JCTiledViewDemo
//
//  Created by Jesse Collis on 8/02/12.
//  Copyright 2012 JC Multimedia Design. All rights reserved.
//

#import "DetailView.h"

@implementation DetailView

- (id)initWithFrame:(CGRect)frame
{
  if ((self = [super initWithFrame:frame]))
  {
    self.backgroundColor = [UIColor blackColor];
    
    _textLabel = [[UILabel alloc] initWithFrame:[self bounds]];
    self.textLabel.font = [UIFont systemFontOfSize:17.0f];
    self.textLabel.textColor = [UIColor whiteColor];
    self.textLabel.textAlignment = UITextAlignmentLeft;
    self.textLabel.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.textLabel];
  }
  return self;
}

- (CGSize)sizeThatFits:(CGSize)size
{
  return CGSizeMake(size.width, 20.f);
}

- (void)layoutSubviews
{
  self.textLabel.frame = CGRectInset(self.bounds, 2.f, 2.f);
}

@end
