//
//  JCTiledPDFScrollView.h
//  JCTiledViewDemo
//
//  Created by Jesse Collis on 23/02/12.
//  Copyright (c) 2012 JC Multimedia Design. All rights reserved.
//

#import "JCTiledScrollView.h"

@interface JCTiledPDFScrollView : JCTiledScrollView {
  @private
  CGPDFDocumentRef _PDFDocRef;
	CGPDFPageRef _PDFPageRef;
}

- (id)initWithFrame:(CGRect)frame URL:(NSURL *)url;

@end
