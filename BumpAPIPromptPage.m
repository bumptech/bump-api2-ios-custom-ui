//
//  BumpAPIPromptPage.m
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

#import "BumpAPIPromptPage.h"
#import "BumpAPIUI.h"

#define HANDS_SIZE 72
#define HANDS_ABOVE_CENTER 15
#define TEXT_ABOVE_CENTER 10
#define TEXT_HEIGHT 20
#define SUB_TEXT_HEIGHT 60
#define MARGIN 10

@implementation BumpAPIPromptPage
- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		
		UIImage *handsImg = [UIImage imageNamed:@"BumpAPIAssets.bundle/ready.png"];
		
		_handsView = [[UIImageView alloc] initWithFrame:CGRectZero];
		[_handsView setImage:handsImg];
		_promptView = [[UILabel alloc] initWithFrame:CGRectZero];
		_subTextView = [[UILabel alloc] initWithFrame:CGRectZero];
		
		[_promptView setBackgroundColor:[UIColor clearColor]];
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

#pragma mark -
- (void)dealloc {
	[_handsView release];
	[_promptView release];
	[_subTextView release];
    [super dealloc];
}
@end
