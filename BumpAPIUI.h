//
//  BumpAPIUI.h
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

#import <UIKit/UIKit.h>
#import "BumpAPI.h"
#import "BumpAPICustomUI.h"
#import "BumpAPIPopup.h"

#define BumpAPIUIDefaultFont [UIFont systemFontOfSize:18.0]
#define BumpAPIUIBoldFont [UIFont boldSystemFontOfSize:18.0]
#define BumpAPIUISmallFont [UIFont systemFontOfSize:16.0]

@interface BumpAPIUI : NSObject <BumpAPICustomUI, BumpAPIPopupDelegate> {
    UIView *_parentView;
	UIView *_uiContainer;
	BumpAPIPopup *_thePopup;
	BumpAPI *_bumpAPIObject;
	
	//The string displayed to prompt the user to connect with another user
	//Save in an instance variable so we can use it in transitional states
	NSString *_connectWithString;
}
@property (nonatomic, assign) UIView *parentView;
@property (nonatomic, assign) id bumpAPIObject;
@end