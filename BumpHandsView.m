//
//  BumpHandsView.m
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

#import "BumpHandsView.h"

//distances in percentage of image size
#define PULLBACK_DISTANCE 0.20
#define RECOIL_DISTANCE 0.10

//time intervals as number of seconds
#define PULLBACK_INTERVAL 0.2
#define BUMP_INTERVAL 0.3
#define BUMP_RECOIL_INTERVAL 0.1
#define BUMP_FINAL_INTERVAL 0.1

//time between bump anis
#define BUMP_DELAY 3.0

#define MODE_READY 1
#define MODE_SOLID 2

@implementation BumpHandsView

#pragma mark -
#pragma mark Initialization

- (void) layoutPieces{
	
	//Hands are scaled to height of default frame
	CGFloat handScale = handImageSize.height != 0.0 ? (self.bounds.size.height / handImageSize.height) : 0.0;
	CGSize handSize = CGSizeMake(handImageSize.width * handScale,
						  handImageSize.height * handScale);
	
	//Left hand all the way left and bottom
	defaultLeftHandFrame = CGRectMake(0,
									  self.bounds.size.height - handSize.height,
									  handSize.width,
									  handSize.height);
	
	//Right all the way right and bottom
	defaultRightHandFrame = CGRectMake(self.bounds.size.width - handSize.width, 
									   self.bounds.size.height - handSize.height,
									   handSize.width,
									   handSize.height);


	//Signals scaled to width of default frame and centered
	float signalScale = signalImageSize.height != 0.0 ? (self.bounds.size.width / signalImageSize.width) : 0.0;
	CGRect signalFrame = CGRectMake(0,
									0,
									signalImageSize.width * signalScale,
									signalImageSize.height * signalScale);
	
	[leftHand setFrame:defaultLeftHandFrame];
	[rightHand setFrame:defaultRightHandFrame];
	[signalImageView setFrame:signalFrame];
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
    	[self setClipsToBounds:NO];

		UIImage *signalImage = [UIImage imageNamed:@"BumpAPIAssets.bundle/bump_signal.png"];
		signalImageSize = signalImage.size;
		
		signalImageView = [[UIImageView alloc] initWithImage:signalImage];
		
		UIImage *handImage = [UIImage imageNamed:@"BumpAPIAssets.bundle/bump_hand.png"];
		handImageSize = handImage.size;
    	leftHand  = [[UIImageView alloc] initWithImage:handImage];
    	rightHand = [[UIImageView alloc] initWithImage:handImage];
		
		[rightHand setTransform:CGAffineTransformMakeScale(-1.0, 1.0)];
		
		[self layoutPieces];

		[self addSubview:signalImageView];
    	[self addSubview:leftHand];
    	[self addSubview:rightHand];

    	mode = -1;
    	[self stopAnimating];
    }
    return self;
}

- (void)dealloc {
	[NSObject cancelPreviousPerformRequestsWithTarget:self];
	[leftHand release];
	[rightHand release];
	[super dealloc];
}

- (void) setFrame:(CGRect)frame{
	[super setFrame:frame];
	[self layoutPieces];
}

#pragma mark Bump Animation Chain
- (void) startBumpAni{
	@synchronized(self){
		//only continue bumping animation if we're still in ready mode
		if(mode != MODE_READY){
			isBumpAnimating = NO;
			return;
		}
	}
	CGPoint newLeft = CGPointMake(CGRectGetMidX(defaultLeftHandFrame) - (int)(PULLBACK_DISTANCE * defaultLeftHandFrame.size.width), CGRectGetMidY(defaultLeftHandFrame));
	CGPoint newRight = CGPointMake(CGRectGetMidX(defaultRightHandFrame) + (int)(PULLBACK_DISTANCE * defaultRightHandFrame.size.width), CGRectGetMidY(defaultRightHandFrame));
	//hands pull back to get ready to bump
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDuration:PULLBACK_INTERVAL];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(handsInitialBump)];
	[leftHand setCenter:newLeft];
	[rightHand setCenter:newRight];
	[UIView commitAnimations];	
}

- (void) handsInitialBump{
	//hands colide for the first time
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	[UIView setAnimationDuration:BUMP_INTERVAL];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(handsRecoil)];
	[leftHand setFrame:defaultLeftHandFrame];
	[rightHand setFrame:defaultRightHandFrame];
	[UIView commitAnimations];
}

- (void) handsRecoil{
	//tiny recoil from the bump
	CGPoint newLeft = CGPointMake(CGRectGetMidX(defaultLeftHandFrame) - (int)(RECOIL_DISTANCE * defaultLeftHandFrame.size.width), CGRectGetMidY(defaultLeftHandFrame));
	CGPoint newRight = CGPointMake(CGRectGetMidX(defaultRightHandFrame) + (int)(RECOIL_DISTANCE * defaultRightHandFrame.size.width), CGRectGetMidY(defaultRightHandFrame));
	//hands pull back to get ready to bump
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDuration:BUMP_RECOIL_INTERVAL];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(handsEndBump)];
	[leftHand setCenter:newLeft];
	[rightHand setCenter:newRight];
	[UIView commitAnimations];
	
}

- (void) handsEndBump{
	//come togetehr again after the tiny recoil
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDuration:BUMP_FINAL_INTERVAL];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(bumpAniDone)];
	[leftHand setFrame:defaultLeftHandFrame];
	[rightHand setFrame:defaultRightHandFrame];
	[UIView commitAnimations];
}

- (void) bumpAniDone{
	@synchronized(self){
		//only continue bumping animation if we're still in ready mode, otherwise return
		if(mode != MODE_READY){
			isBumpAnimating = NO;
			return;
		} else{
			[self performSelector:@selector(startBumpAni) withObject:nil afterDelay:BUMP_DELAY];
		}
	}
}

#pragma mark Public Methods
- (void) startAnimating{
	if(mode != MODE_READY){
		mode = MODE_READY;
		//start animation chain
		if(!isBumpAnimating){
			[self startBumpAni];
			isBumpAnimating = YES;
		}
	}
}

- (void) stopAnimating{
	if(mode != MODE_SOLID){
		//Next time the animation finishes it won't repeat
		//once we set the mode to solid.
		mode = MODE_SOLID;
	}
}
@end