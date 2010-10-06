//
//  BumpAPIUI.h
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
#import "BumpAPIPopup.h"

#define BumpAPIUIDefaultFont [UIFont systemFontOfSize:18.0]
#define BumpAPIUIBoldFont [UIFont boldSystemFontOfSize:18.0]
#define BumpAPIUISmallFont [UIFont systemFontOfSize:16.0]

@interface BumpAPIUI : NSObject <BumpMatchUI, BumpAPIPopupDelegate> {
    UIView *_parentView;
	UIView *_uiContainer;
	BumpAPIPopup *_thePopup;
	BumpAPI *_bumpAPIObject;
}
@property (nonatomic, assign) UIView *parentView;
@property (nonatomic, assign) id bumpAPIObject;
@end