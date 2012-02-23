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
@end

static const CGFloat kDefaultTileSize = 256.;

@implementation JCPDFTiledView

- (CGSize)tileSize;
{
  return CGSizeMake(kDefaultTileSize, kDefaultTileSize);
}

- (void)drawRect:(CGRect)rect
{
  CGContextRef ctx = UIGraphicsGetCurrentContext();

	CGPDFPageRef drawPDFPageRef = NULL;

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
  
  //hidden
  [self annotateRect:rect inContext:ctx];
}

@end
