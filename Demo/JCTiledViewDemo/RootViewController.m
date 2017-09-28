//
//  RootViewController.m
//  JCTiledViewDemo
//
//  Created by Jesse Collis
//  Copyright (c) 2012 JC Multimedia Design. All rights reserved.
//

#import "RootViewController.h"
#import "JCTiledPDFScrollView.h"
#import "DemoAnnotationView.h"
#import "DemoAnnotation.h"
#import "math.h"
#import "DetailView.h"

#define SkippingGirlImageSize CGSizeMake(432., 648.)

#ifdef ANNOTATE_TILES
#import "JCTiledView.h"
#endif

@interface RootViewController ()

@property (nonatomic, strong) NSArray *bezierPaths;
@end

@implementation RootViewController


#pragma mark - View lifecycle

- (void)loadView
{
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 460.0f)];
  view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
  self.view = view;
}

- (void)viewDidLoad
{
  [super viewDidLoad];

  self.detailView = [[DetailView alloc] initWithFrame:CGRectZero];
  self.detailView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  CGSize size_for_detail = [self.detailView sizeThatFits:self.view.bounds.size];
  [self.detailView setFrame:CGRectMake(0.f,0.f,size_for_detail.width,size_for_detail.height)];
  [self.view addSubview:self.detailView];

  CGRect scrollView_frame = CGRectOffset(CGRectInset(self.view.bounds,0.,size_for_detail.height/2.0f),0.,size_for_detail.height/2.0f);

  //PDF
  //self.scrollView = [[JCTiledPDFScrollView alloc] initWithFrame:scrollView_frame URL:[[NSBundle mainBundle] URLForResource:@"Map" withExtension:@"pdf"]];

  //Bitmap
  self.scrollView = [[JCTiledScrollView alloc] initWithFrame:scrollView_frame contentSize:SkippingGirlImageSize];

  self.scrollView.dataSource = self;
  self.scrollView.tiledScrollViewDelegate = self;
  self.scrollView.zoomScale = 1.0f;

#ifdef ANNOTATE_TILES
  self.scrollView.tiledView.shouldAnnotateRect = YES;
#endif
  
  // totals 4 sets of tiles across all devices, retina devices will miss out on the first 1x set
  self.scrollView.levelsOfZoom = 3;
  self.scrollView.levelsOfDetail = 3;

  [self.view addSubview:self.scrollView];
  
  UIButton *addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  [addButton setTitle:@"+ Annotations" forState:UIControlStateNormal];
  addButton.frame = CGRectMake(CGRectGetWidth(self.view.frame) - 115, 25., 110, 38);
  addButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
  [addButton addTarget:self action:@selector(addRandomAnnotations) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:addButton];
    
  [self tiledScrollViewDidZoom:self.scrollView]; //force the detailView to update the frist time
  [self addRandomAnnotations];

}

- (void)viewDidUnload
{
  _scrollView = nil;
  _detailView = nil;

  [super viewDidUnload];
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  
  [self.scrollView refreshAnnotations];
  
  [self becomeFirstResponder];
}

#pragma mark - Rotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return YES;
}

#pragma mark - Responder

- (BOOL)canBecomeFirstResponder
{
  return YES;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
  if (event.type == UIEventTypeMotion && event.subtype == UIEventSubtypeMotionShake)
  {
    [self.scrollView removeAllAnnotations];
  }
}

#pragma mark - Annotations

- (void)addRandomAnnotations
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        srand(42);
    });
    
    CGSize size           = SkippingGirlImageSize;
    
    NSMutableArray *paths = [NSMutableArray array];
    
    for (int i = 0; i < 6/2; i++) {
        
        id<JCAnnotation> firstAnnot    = [[DemoAnnotation alloc] init];
        CGPoint firstContentPosition = CGPointMake((float)(rand() % (int)size.width), (float)(rand() % (int)size.height));
        firstAnnot.contentPosition     = firstContentPosition;
        id<JCAnnotation> secondAnnot    = [[DemoAnnotation alloc] init];
        CGPoint secondContentPosition = CGPointMake((float)(rand() % (int)size.width), (float)(rand() % (int)size.height));
        secondAnnot.contentPosition     = secondContentPosition;
        [self.scrollView addAnnotation:firstAnnot];
        [self.scrollView addAnnotation:secondAnnot];
        
        
        UIBezierPath *path    = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(firstContentPosition.x, firstContentPosition.y + 30.f)]; // 30.f is max height of the annotation image
        [path addLineToPoint:CGPointMake(secondContentPosition.x, secondContentPosition.y + 30.f)]; // 30.f is max height of the annotation image
        path.lineWidth = 3.f;
        [paths addObject:path];
    }
    
    self.bezierPaths = [NSArray arrayWithArray:paths];
    
}

#pragma mark - JCTiledScrollViewDelegate

- (void)tiledScrollViewDidZoom:(JCTiledScrollView *)scrollView
{
  self.detailView.textLabel.text = [NSString stringWithFormat:@"zoomScale: %0.2f", scrollView.zoomScale];
}

- (void)tiledScrollView:(JCTiledScrollView *)scrollView didReceiveSingleTap:(UIGestureRecognizer *)gestureRecognizer
{
  CGPoint tapPoint = [gestureRecognizer locationInView:(UIView *)scrollView.tiledView];

  //tap point on the tiledView does not inlcude the zoomScale applied by the scrollView
  self.detailView.textLabel.text = [NSString stringWithFormat:@"zoomScale: %0.2f, x: %0.0f y: %0.0f", scrollView.zoomScale, tapPoint.x, tapPoint.y];
}

- (JCAnnotationView *)tiledScrollView:(JCTiledScrollView *)scrollView viewForAnnotation:(id<JCAnnotation>)annotation
{
  NSString static *reuseIdentifier = @"JCAnnotationReuseIdentifier";
  DemoAnnotationView *view = (DemoAnnotationView *)[scrollView dequeueReusableAnnotationViewWithReuseIdentifier:reuseIdentifier];

  if (!view)
  {
    view = [[DemoAnnotationView alloc] initWithFrame:CGRectZero annotation:annotation reuseIdentifier:@"Identifier"];
    view.imageView.image = [UIImage imageNamed:@"marker-red.png"];
    [view sizeToFit];
  }

  return view;
}

#pragma mark - JCTileSource

#define SkippingGirlImageName @"SkippingGirl"

- (UIImage *)tiledScrollView:(JCTiledScrollView *)scrollView imageForRow:(NSInteger)row column:(NSInteger)column scale:(NSInteger)scale
{
 return [UIImage imageNamed:[NSString stringWithFormat:@"tiles/%@_%ldx_%ld_%ld.png", SkippingGirlImageName, scale, row, column]];
}


-(UIBezierPath *)tiledScrollViewGetBezierPath:(JCTiledScrollView *)scrollView atIndex:(NSInteger)index{
    return [self.bezierPaths objectAtIndex:index];
}

- (UIColor *)tiledScrollViewGetPathColor:(JCTiledScrollView *)scrollView atIndex:(NSInteger)index {
    //UIColor *color = [UIColor colorWithRed:38.f/255.f green:166.f/255.f blue:91.f/255.f alpha:1.f];
    UIColor *color = [UIColor whiteColor];
    return color;
}

- (NSInteger)tiledScrollViewGetNumberOfPath:(JCTiledScrollView *)scrollView {
    return [self.bezierPaths count];
}


@end
