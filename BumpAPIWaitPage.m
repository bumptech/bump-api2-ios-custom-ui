//
//  BumpAPIWaitPage.m
//  BumpAPI
//
//  Copyrights / Disclaimer
//  Copyright 2010, Bump Technologies, Inc. All rights reserved.
//  Use of the software programs described herein is subject to applicable
//  license agreements and nondisclosure agreements. Unless specifically
//  otherwise agreed in writing, all rights, title, and interest to this
//  software and documentation remain with Bump Technologies, Inc. Unless
//  expressly agreed in a signed license agreement, Bump Technologies makes
//  no representations about the suitability of this software for any purpose
//  and it is provided "as is" without express or implied warranty.
//
//  Copyright (c) 2010 Bump Technologies Inc. All rights reserved.
//

#import "BumpAPIWaitPage.h"
#import "BumpAPIUI.h"

#define SPINNER_SIZE 48
#define SPINNER_BELOW_CENTER 0
#define TEXT_ABOVE_CENTER 10
#define TEXT_HEIGHT 40
#define MARGIN 10

@implementation BumpAPIWaitPage
- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		_spinnerView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectZero];
		[_spinnerView setHidesWhenStopped:YES];
		[_spinnerView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
		_promptView = [[UILabel alloc] initWithFrame:CGRectZero];
		[_promptView setBackgroundColor:[UIColor clearColor]];
		
		[_promptView setFont:BumpAPIUIDefaultFont];
		[_promptView setTextAlignment:UITextAlignmentCenter];
		[_promptView setNumberOfLines:0];
		
		[self addSubview:_spinnerView];
		[self addSubview:_promptView];
    }
    return self;
}

- (void) layoutSubviews{
	//Determine all the view's rects first
	CGFloat viewW = self.bounds.size.width;
	CGFloat viewH = self.bounds.size.height;
	
	CGFloat vCenter = viewH / 2.0;
	CGFloat hCenter = viewW / 2.0;
	
	CGRect spinnerRect = CGRectMake(hCenter - (SPINNER_SIZE / 2.0),
								  vCenter + SPINNER_BELOW_CENTER,
								  SPINNER_SIZE,
								  SPINNER_SIZE);
	
	CGRect textRect = CGRectMake(MARGIN,
								 vCenter - TEXT_ABOVE_CENTER - TEXT_HEIGHT,
								 viewW - 2.0 * MARGIN,
								 TEXT_HEIGHT);
	
	//Use CGRectIntegral to round all of the rects to nice pixel boundaries
	spinnerRect = CGRectIntegral(spinnerRect);
	textRect = CGRectIntegral(textRect);
	
	[_spinnerView setFrame:spinnerRect];
	[_promptView setFrame:textRect];
}

#pragma mark -
- (void)startSpinner{
	[_spinnerView startAnimating];
}
- (void)stopSpinner{
	[_spinnerView stopAnimating];
}
- (void)setPromptText:(NSString *)text{
	[_promptView setText:text];
}

- (void)dealloc {
	[_spinnerView release];
	[_promptView release];
    [super dealloc];
}
@end
