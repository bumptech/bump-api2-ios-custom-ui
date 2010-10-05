//
//  BumpAPIConfirmPage.m
//  Bump API
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

#import "BumpAPIConfirmPage.h"
#import "BumpAPIUI.h"

#define MUG_SIZE 60
#define MUG_ABOVE_CENTER 30
#define TEXT_ABOVE_CENTER 10
#define TEXT_HEIGHT 50
#define MARGIN 10
#define YES_W 95
#define NO_W 65
#define YES_NO_SPACE 26
#define YES_NO_HEIGHT 45

@interface BumpAPIConfirmPage ()
@property (nonatomic, retain) UIButton *yesButton;
@property (nonatomic, retain) UIButton *noButton;
@end

@implementation BumpAPIConfirmPage
@synthesize yesButton = _yesButton;
@synthesize noButton = _noButton;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		_mugView = [[UIImageView alloc] initWithFrame:CGRectZero];
		[_mugView setImage:[UIImage imageNamed:@"BumpAPIAssets.bundle/anon_pic.png"]];
		
		_promptView = [[UILabel alloc] initWithFrame:CGRectZero];
		[_promptView setBackgroundColor:[UIColor clearColor]];
		[_promptView setFont:BumpAPIUIDefaultFont];
		[_promptView setTextAlignment:UITextAlignmentCenter];
		[_promptView setNumberOfLines:3];
		self.yesButton = [UIButton buttonWithType:UIButtonTypeCustom];
		self.noButton  = [UIButton buttonWithType:UIButtonTypeCustom];
		
		UIImage *buttonImage = [[UIImage imageNamed:@"BumpAPIAssets.bundle/button.png"]
					    stretchableImageWithLeftCapWidth:7 topCapHeight:7];
		[_yesButton setBackgroundImage:buttonImage
					forState:UIControlStateNormal];
		[_yesButton setTitle:NSLocalizedStringFromTable(@"Yes", @"BumpApiLocalizable", @"Yes button for Bump API popup") forState:UIControlStateNormal];
		
		[_noButton setBackgroundImage:buttonImage
					forState:UIControlStateNormal];
		[_noButton setTitle:NSLocalizedStringFromTable(@"No", @"BumpApiLocalizable", @"No button for Bump API popup") forState:UIControlStateNormal];
		
		[self addSubview:_mugView];
		[self addSubview:_promptView];
		[self addSubview:_yesButton];
		[self addSubview:_noButton];
    }
    return self;
}

- (void) layoutSubviews{
	//Determine all the view's rects first
	CGFloat viewW = self.bounds.size.width;
	CGFloat viewH = self.bounds.size.height;
	
	CGFloat vCenter = viewH / 2.0;
	CGFloat hCenter = viewW / 2.0;
	
	CGRect mugRect = CGRectMake(hCenter - (MUG_SIZE / 2.0),
								vCenter - MUG_ABOVE_CENTER - MUG_SIZE,
								MUG_SIZE,
								MUG_SIZE);
	
	CGRect textRect = CGRectMake(MARGIN,
								 vCenter - TEXT_ABOVE_CENTER,
								 viewW - 2.0 * MARGIN,
								 TEXT_HEIGHT);
	
	CGFloat yesNoExtraW = viewW - 2.0 * MARGIN - (YES_NO_SPACE + YES_W + NO_W);
	
	CGFloat yesX = MARGIN + (yesNoExtraW / 2.0);
	CGFloat yesY = viewH - MARGIN - YES_NO_HEIGHT;
	
	CGRect yesBtnRect = CGRectMake(yesX,
								   yesY,
								   YES_W,
								   YES_NO_HEIGHT);
	
	CGRect noBtnRect = CGRectMake(CGRectGetMaxX(yesBtnRect) + YES_NO_SPACE,
								  yesY, 
								  NO_W,
								  YES_NO_HEIGHT);
	
	//Use CGRectIntegral to round all of the rects to nice pixel boundaries
	mugRect = CGRectIntegral(mugRect);
	textRect = CGRectIntegral(textRect);
	yesBtnRect = CGRectIntegral(yesBtnRect);
	noBtnRect = CGRectIntegral(noBtnRect);
	
	[_mugView setFrame:mugRect];
	[_promptView setFrame:textRect];
	[_yesButton setFrame:yesBtnRect];
	[_noButton setFrame:noBtnRect];
}

- (void)setPromptText:(NSString *)text{
	[_promptView setText:text];
}

- (void)setMugImage:(UIImage *)mug{
	[_mugView setImage:mug];
}

- (void)dealloc {
	self.yesButton = nil;
	self.noButton = nil;
	[_mugView release];
	[_promptView release];
    [super dealloc];
}
@end