//
//  JCTiledPDFScrollView.m
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

#import "JCTiledPDFScrollView.h"
#import "JCPDFTiledView.h"
#import "CGPDFDocument.h"

@interface JCTiledPDFScrollView () <JCPDFTiledViewDelegate>
@end

@implementation JCTiledPDFScrollView

+ (Class)tiledLayerClass
{
  return [JCPDFTiledView class];
}

- (instancetype)initWithFrame:(CGRect)frame URL:(NSURL *)url
{
  CGSize contentSize = CGSizeZero;
  
  _PDFDocRef = CGPDFDocumentCreateX((__bridge CFURLRef)url, @"");
  
  if (_PDFDocRef != NULL)
  {
    _PDFPageRef = CGPDFDocumentGetPage(_PDFDocRef, 1);
    
    if (_PDFPageRef != NULL)
    {
      CGPDFPageRetain(_PDFPageRef);
      
      CGRect cropBoxRect = CGPDFPageGetBoxRect(_PDFPageRef, kCGPDFCropBox);
      CGRect mediaBoxRect = CGPDFPageGetBoxRect(_PDFPageRef, kCGPDFMediaBox);
      CGRect effectiveRect = CGRectIntersection(cropBoxRect, mediaBoxRect);
      
      contentSize = effectiveRect.size;
    }
    else
    {
      CGPDFDocumentRelease(_PDFDocRef);
      _PDFDocRef = NULL;
      
      NSAssert(NO, @"CGPDFPageRef == NULL");
    }
  }
  else
  {
    NSAssert(NO, @"CGPDFDocumentRef == NULL");
  }
  
  if ((self = [super initWithFrame:frame contentSize:contentSize]))
  {
  }

  return self;
}

- (void)dealloc
{
  CGPDFPageRelease(_PDFPageRef);
  CGPDFDocumentRelease(_PDFDocRef);
}

//MARK: JCPDFTiledViewDelegate

- (CGPDFDocumentRef)pdfDocumentForTiledView:(__unused JCPDFTiledView *)tiledView
{
  return _PDFDocRef;
}

- (CGPDFPageRef)pdfPageForTiledView:(__unused JCPDFTiledView *)tiledView
{
  return _PDFPageRef;
}

@end
