//
//  BumpAPIWaitPage.m
//  BumpAPI
//
//  Copyright (c) 2010, Bump Technologies, Inc.
//  All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//      * Redistributions of source code must retain the above copyright
//        notice, this list of conditions and the following disclaimer.
//      * Redistributions in binary form must reproduce the above copyright
//        notice, this list of conditions and the following disclaimer in the
//        documentation and/or other materials provided with the distribution.
//      * Neither the name of Bump Technologies, Inc. nor the
//        names of its contributors may be used to endorse or promote products
//        derived from this software without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
//  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "BumpAPIWaitPage.h"
#import "BumpAPIUI.h"

#define SPINNER_SIZE 48
#define SPINNER_BELOW_CENTER 20 //How far bellow center the top edge of the spinner is.
#define TEXT_ABOVE_CENTER -15 //How far above center the bottom edge of the text view is.
#define TEXT_HEIGHT 90
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
