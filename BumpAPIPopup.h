//
//  BumpAPIPopup.h
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

#import <UIKit/UIKit.h>
#import "BumpAPI.h"
#import "BumpAPINoUI.h"

#define SCALE_PHASE1			0.1
#define SCALE_PHASE2			1.2
#define SCALE_PHASE3			0.95

#define FADE_IN_DURATION1		0.2
#define FADE_IN_DURATION2		0.1
#define FADE_IN_DURATION3		0.175

#define BG_IMG_LEFT_CAP_WIDTH	20
#define BG_IMG_TOP_CAP_HEIGHT	20

#define BP_POPUP_MARGIN			10

@protocol BumpAPIPopupDelegate <NSObject>
- (void) popupCloseButtonPressed;
@end
    
@interface BumpAPIPopup : UIView{
	id<BumpAPIPopupDelegate> _delegate;
	UIView *_popupContent;
	UIView *_currentPage;
	UIButton *_closeButton;
	CGRect _closeHitArea;
}

@property (nonatomic, assign) id<BumpAPIPopupDelegate> delegate;
- (void)show;
- (void)changePage:(UIView *)newPage;
@end
