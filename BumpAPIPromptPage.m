//
//  BumpAPIPromptPage.m
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

#import "BumpAPIPromptPage.h"
#import "BumpAPIUI.h"

#define HANDS_SIZE 72
#define HANDS_ABOVE_CENTER 25
#define TEXT_ABOVE_CENTER 20
#define TEXT_HEIGHT 40
#define SUB_TEXT_HEIGHT 60
#define MARGIN 5

@implementation BumpAPIPromptPage
- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		
		_handsView = [[BumpHandsView alloc] initWithFrame:CGRectZero];
		_promptView = [[UILabel alloc] initWithFrame:CGRectZero];
		_subTextView = [[UILabel alloc] initWithFrame:CGRectZero];
		
		[_promptView setBackgroundColor:[UIColor clearColor]];
		[_promptView setNumberOfLines:2];
		[_subTextView setBackgroundColor:[UIColor clearColor]];
		[_subTextView setNumberOfLines:4];
		
		[_promptView setFont:BumpAPIUIBoldFont];
		[_promptView setTextAlignment:UITextAlignmentCenter];
		
		[_subTextView setFont:BumpAPIUISmallFont];
		[_subTextView setTextAlignment:UITextAlignmentCenter];
		
		[self addSubview:_handsView];
		[self addSubview:_promptView];
		[self addSubview:_subTextView];
    }
    return self;
}

- (void) layoutSubviews{
	//Determine all the view's rects first
	CGFloat viewW = self.bounds.size.width;
	CGFloat viewH = self.bounds.size.height;
	
	CGFloat vCenter = viewH / 2.0;
	CGFloat hCenter = viewW / 2.0;
	
	CGRect handsRect = CGRectMake(hCenter - (HANDS_SIZE / 2.0),
								vCenter - HANDS_ABOVE_CENTER - HANDS_SIZE,
								HANDS_SIZE,
								HANDS_SIZE);
	
	CGRect textRect = CGRectMake(MARGIN,
								 vCenter - TEXT_ABOVE_CENTER,
								 viewW - 2.0 * MARGIN,
								 TEXT_HEIGHT);
	
	CGRect subTextRect = CGRectMake(MARGIN,
									CGRectGetMaxY(textRect) + MARGIN,
									textRect.size.width, 
									SUB_TEXT_HEIGHT);
	
	//Use CGRectIntegral to round all of the rects to nice pixel boundaries
	handsRect = CGRectIntegral(handsRect);
	textRect = CGRectIntegral(textRect);
	subTextRect = CGRectIntegral(subTextRect);
	
	[_handsView setFrame:handsRect];
	[_promptView setFrame:textRect];
	[_subTextView setFrame:subTextRect];
}


#pragma mark -
-(void) setPromptText:(NSString *)text{
	//[_promptView setText:text];
	[_promptView setText:text];
}

-(void) setSubText:(NSString *)text{
	//[_subTextView setText:text];
	[_subTextView setText:text];
}

-(void) animateHands:(BOOL)animate{
	if(animate){
		[_handsView startAnimating];
	} else {
		[_handsView stopAnimating];		
	}
}

#pragma mark -
- (void)dealloc {
	[_handsView release];
	[_promptView release];
	[_subTextView release];
    [super dealloc];
}
@end
