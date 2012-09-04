//
//  JCPDFTiledView.m
//
//  Created by Jesse Collis on 20/02/12.
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

- (void)drawRect:(__unused CGRect)rect
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
}

@end
