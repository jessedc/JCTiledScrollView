//
//  JCTiledPDFScrollView.m
//  JCTiledViewDemo
//
//  Created by Jesse Collis on 23/02/12.
//  Copyright (c) 2012 JC Multimedia Design. All rights reserved.
//

#import "JCTiledPDFScrollView.h"
#import "JCPDFTiledView.h"
#import "CGPDFDocument.h"

@interface JCTiledPDFScrollView () <JCPDFTiledViewDelegate>
@end

@implementation JCTiledPDFScrollView

+ (Class)tiledLayerClass;
{
  return [JCPDFTiledView class];
}

//[[NSBundle mainBundle] URLForResource:@"Map" withExtension:@"pdf"]

- (id)initWithFrame:(CGRect)frame URL:(NSURL *)url;
{
  CGSize contentSize = CGSizeZero;
  
  _PDFDocRef = CGPDFDocumentCreateX((CFURLRef)url, @"");
  
  if (_PDFDocRef != NULL) // Check for non-NULL CGPDFDocumentRef
  {
    _PDFPageRef = CGPDFDocumentGetPage(_PDFDocRef, 1);
    
    if (_PDFPageRef != NULL) // Check for non-NULL CGPDFPageRef
    {
      CGPDFPageRetain(_PDFPageRef); // Retain the PDF page
      
      CGRect cropBoxRect = CGPDFPageGetBoxRect(_PDFPageRef, kCGPDFCropBox);
      CGRect mediaBoxRect = CGPDFPageGetBoxRect(_PDFPageRef, kCGPDFMediaBox);
      CGRect effectiveRect = CGRectIntersection(cropBoxRect, mediaBoxRect);
      
      contentSize = effectiveRect.size;
    }
    else // Error out with a diagnostic
    {
      CGPDFDocumentRelease(_PDFDocRef);
      _PDFDocRef = NULL;
      
      NSAssert(NO, @"CGPDFPageRef == NULL");
    }
  }
  else // Error out with a diagnostic
  {
    NSAssert(NO, @"CGPDFDocumentRef == NULL");
  }
  
  if (self = [super initWithFrame:frame contentSize:contentSize])
  {
  }

  return self;
}

- (void)dealloc
{
  CGPDFPageRelease(_PDFPageRef);
  CGPDFDocumentRelease(_PDFDocRef);

  [super dealloc];
}

#pragma mark - JCPDFTiledViewDelegate

- (CGPDFDocumentRef)pdfDocumentForTiledView:(JCPDFTiledView *)tiledView;
{
  return _PDFDocRef;
}

- (CGPDFPageRef)pdfPageForTiledView:(JCPDFTiledView *)tiledView;
{
  return _PDFPageRef;
}

@end
