//
//  JCTiledPDFScrollView.m
//
//  Created by Jesse Collis on 23/02/12.
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

- (id)initWithFrame:(CGRect)frame URL:(NSURL *)url
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

#pragma mark - JCPDFTiledViewDelegate

- (CGPDFDocumentRef)pdfDocumentForTiledView:(__unused JCPDFTiledView *)tiledView
{
  return _PDFDocRef;
}

- (CGPDFPageRef)pdfPageForTiledView:(__unused JCPDFTiledView *)tiledView
{
  return _PDFPageRef;
}

@end
