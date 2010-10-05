//
//  BumpAPIConfirmPage.h
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

#import <UIKit/UIKit.h>

@interface BumpAPIConfirmPage : UIView {
	UIImageView *_mugView;
	UILabel *_promptView;
	UIButton *_yesButton;
	UIButton *_noButton;
}

@property (nonatomic, retain, readonly) UIButton *yesButton;
@property (nonatomic, retain, readonly) UIButton *noButton;

- (void)setPromptText:(NSString *)text;
- (void)setMugImage:(UIImage *)mug;

@end
