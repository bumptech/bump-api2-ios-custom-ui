//
//  BumpAPIConfirmPage.m
//  Bump API
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
		[_mugView setImage:[UIImage imageNamed:@"BumpAPIAssets.bundle/ready.png"]];
		
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