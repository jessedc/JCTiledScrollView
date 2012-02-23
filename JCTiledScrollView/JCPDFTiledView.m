//
//  JCPDFTiledView.m
//  JCTiledViewDemo
//
//  Created by Jesse Collis on 20/02/12.
//  Copyright (c) 2012 JC Multimedia Design. All rights reserved.
//

#import "JCPDFTiledView.h"
#import "JCTiledLayer.h"
#import "CGPDFDocument.h"

@interface JCPDFTiledView ()
@property (nonatomic, assign) CGSize tileSize;
@property (nonatomic, assign) CGSize scaledTileSize;
@end

static const CGFloat kDefaultTileSize = 512.0f;

@implementation JCPDFTiledView

@synthesize tileSize = tileSize_;
@synthesize scaledTileSize = scaledTileSize_;

+(Class)layerClass
{
  return [JCTiledLayer class];
}

- (JCTiledLayer *)tiledLayer
{
  return (JCTiledLayer *)self.layer;
}

- (id)initWithFrame:(CGRect)frame
{
  if ((self = [super initWithFrame:frame]))
  {
    self.tileSize = CGSizeMake(kDefaultTileSize, kDefaultTileSize);
    self.scaledTileSize = CGSizeApplyAffineTransform(self.tileSize, CGAffineTransformMakeScale(self.contentScaleFactor, self.contentScaleFactor));
    
    self.tiledLayer.tileSize = self.scaledTileSize;
    self.tiledLayer.levelsOfDetail = 1;
    self.numberOfZoomLevels = 3;
  }
  
  return self;
}

- (void)setNumberOfZoomLevels:(size_t)levels
{
  self.tiledLayer.levelsOfDetailBias = levels;
}

- (size_t)numberOfZoomLevels
{
  return self.tiledLayer.levelsOfDetailBias;
}

- (void)drawRect:(CGRect)rect
{
  CGContextRef ctx = UIGraphicsGetCurrentContext();

	CGPDFPageRef drawPDFPageRef = NULL;
	//CGPDFDocumentRef drawPDFDocRef = NULL;

  //drawPDFDocRef = CGPDFDocumentRetain(PDFDocRef_);
  drawPDFPageRef = CGPDFPageRetain([(id<JCPDFTiledViewDelegate>)self.delegate pdfPageForTiledView:self]);

	CGContextSetRGBFillColor(ctx, 1.0f, 1.0f, 1.0f, 1.0f);
	CGContextFillRect(ctx, CGContextGetClipBoundingBox(ctx));
  
	if (drawPDFPageRef != NULL)
	{
		CGContextTranslateCTM(ctx, 0.0f, self.bounds.size.height); 
    CGContextScaleCTM(ctx, 1.0f, -1.0f);
    
		CGContextConcatCTM(ctx, CGPDFPageGetDrawingTransform(drawPDFPageRef, kCGPDFCropBox, self.bounds, 0, true));
    
		CGContextSetRenderingIntent(ctx, kCGRenderingIntentDefault); 
    CGContextSetInterpolationQuality(ctx, kCGInterpolationDefault);
    
		CGContextDrawPDFPage(ctx, drawPDFPageRef);
	}
  
	CGPDFPageRelease(drawPDFPageRef);
  //CGPDFDocumentRelease(drawPDFDocRef);
}

@end
