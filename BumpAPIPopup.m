//
//  BumpAPIPopup.m
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

#import "BumpAPIPopup.h"
#import <CoreGraphics/CoreGraphics.h>

#define OUTER_MARGIN 10
#define CONTENT_Y_OFFSET 37
#define CONTENT_H_INSET 8
#define CONTENT_V_INSET 0
#define CONTENT_BOTTOM_MARGIN 12
#define LOGO_OFFSET 6
#define LOGO_HEIGHT 24
#define CLOSE_X_SIZE 11
#define CLOSE_X_OFFSET 8
#define CLOSE_HIT_SIZE 50

@interface BumpAPIPopup ()
@property (nonatomic, retain) UIView *currentPage;
@end

@implementation BumpAPIPopup
@synthesize currentPage = _currentPage;
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		//Use this on a hit test for this main view so that the close x button is easy to hit.
		//The entire CLOSE_HIT_SIZE square in the upper right of the view is the hit area.
		_closeHitArea = CGRectMake(self.bounds.size.width - CLOSE_HIT_SIZE,
								  0,
								  CLOSE_HIT_SIZE,
								  CLOSE_HIT_SIZE);
		
		CGRect mainPopupFrame = CGRectInset([self bounds], OUTER_MARGIN, OUTER_MARGIN);
		UIView *mainPopup = [[UIView alloc] initWithFrame:mainPopupFrame];

		//Popup Background
		UIImage *popupBGImage = [[UIImage imageNamed:@"BumpAPIAssets.bundle/popup.png"]
								 stretchableImageWithLeftCapWidth:10
								 topCapHeight:37];
		
		UIImageView *bgImageView =	[[UIImageView alloc] initWithImage:popupBGImage];
		[bgImageView setFrame:[mainPopup bounds]];
		[mainPopup addSubview:bgImageView];
		[bgImageView release];
		
		//White Bump Logo
		UIImageView *bumpLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BumpAPIAssets.bundle/bump_white.png"]];
		[bumpLogo setContentMode:UIViewContentModeScaleAspectFit];
		[bumpLogo setFrame:CGRectMake(0,
									  LOGO_OFFSET,
									  mainPopup.bounds.size.width,
									  LOGO_HEIGHT)];
		[mainPopup addSubview:bumpLogo];
		[bumpLogo release];
		
		//Close Button
		_closeButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
		[_closeButton setShowsTouchWhenHighlighted:YES];
		[_closeButton setImage:[UIImage imageNamed:@"BumpAPIAssets.bundle/close_popup.png"]
					  forState:UIControlStateNormal];
		[_closeButton addTarget:self
						 action:@selector(closePress)
			   forControlEvents:UIControlEventTouchUpInside];
		[_closeButton setContentMode:UIViewContentModeScaleAspectFit];
		[_closeButton setFrame:CGRectMake(mainPopup.bounds.size.width - CLOSE_X_SIZE - CLOSE_X_OFFSET,
										  CLOSE_X_OFFSET,
										  CLOSE_X_SIZE,
										  CLOSE_X_SIZE)];
		[mainPopup addSubview:_closeButton];
		
		CGRect contentFrame = CGRectMake(CONTENT_H_INSET,
										 CONTENT_V_INSET + CONTENT_Y_OFFSET,
										 mainPopup.bounds.size.width - 2 * CONTENT_H_INSET, 
										 mainPopup.bounds.size.height - CONTENT_Y_OFFSET - 2 * CONTENT_V_INSET - CONTENT_BOTTOM_MARGIN);
		
		_popupContent = [[UIView alloc] initWithFrame:contentFrame];
		[_popupContent setClipsToBounds:YES];
		[mainPopup addSubview:_popupContent];
		[self addSubview:mainPopup];
		[mainPopup release];
    }
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
	if(CGRectContainsPoint(_closeHitArea, point)){
		return _closeButton;
	} else {
		return [super hitTest:point withEvent:event];
	}
}

- (void) closePress{
	if([_delegate respondsToSelector:@selector(popupCloseButtonPressed)]){
		[_delegate popupCloseButtonPressed];	
	}
}

- (void)changePage:(UIView *)newPage{
	BOOL animate = YES;
	[newPage setFrame:[_popupContent bounds]];
		
	// remove the current view and replace with the newPage
	[self.currentPage removeFromSuperview];
	[_popupContent addSubview:newPage];
	self.currentPage = newPage;
	
	// set up an animation for the transition between the views
	CATransition *animation = [CATransition animation];
	[animation setDuration:0.2];
	[animation setType:kCATransitionFade];
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	[[_popupContent layer] addAnimation:animation forKey:@"change_pages"];
}

- (void)dealloc {
	self.currentPage = nil;
    [super dealloc];
}

/*
- (void)drawRect:(CGRect)rect{
	//Draw the close hit area for debugging
	[super drawRect:rect];
	CGContextRef context = UIGraphicsGetCurrentContext();
	[[UIColor greenColor] set];
	CGContextStrokeRect(context, _closeHitArea);
}
*/

#pragma mark -
#pragma mark Private Animation methods
- (void)_pulseGrowAnimationDidStop {
    [UIView beginAnimations:nil context:NULL]; {
        [UIView setAnimationDuration:FADE_IN_DURATION2];
        [UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(_pulseShrinkAnimationDidStop)];
        self.transform = CGAffineTransformScale(CGAffineTransformIdentity, SCALE_PHASE3, SCALE_PHASE3);        
    }
    [UIView commitAnimations];
}

- (void)_pulseShrinkAnimationDidStop {
    [UIView beginAnimations:nil context:NULL]; {
		[UIView setAnimationDuration:FADE_IN_DURATION3];
		self.transform = CGAffineTransformIdentity;
	}
	[UIView commitAnimations];
}

- (void)show {
	self.transform = CGAffineTransformMakeScale(SCALE_PHASE1, SCALE_PHASE1);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:FADE_IN_DURATION1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(_pulseGrowAnimationDidStop)];
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, SCALE_PHASE2, SCALE_PHASE2 );
    [UIView commitAnimations];	
}

@end