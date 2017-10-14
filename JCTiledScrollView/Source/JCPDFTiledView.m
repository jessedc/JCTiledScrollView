//
//  JCPDFTiledView.m
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
