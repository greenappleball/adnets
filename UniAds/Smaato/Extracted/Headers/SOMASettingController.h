//
//  SOMASettingController.h
//  SOMASource
//
//  Copyright ©2009-10 Smaato, Inc.  All Rights Reserved.  Use of this software is subject to the Smaato Terms of Service. 
//
#pragma once
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol SOMASettingControllerDelegate;

/*!
	@class			SOMASettingController
	
	@abstract		Settings Controller.
	@discussion		User Settings Controller.
	@updated		2012-11-12
	@availability	Available since iSoma 4.0 and later.
*/
@interface SOMASettingController : UIViewController<UITextFieldDelegate> {
	id<SOMASettingControllerDelegate> delegate;
	UITextField *gender;
	UITextField *yearofbirth;
	UITextField *interest1;
	UITextField *interest2;
	UITextField *interest3;
}

/*!
	@property		delegate
	@methodgroup    Delegate

	@abstract       A reference to the delegate object.
    @availability	Available since iSoma 4.0 and later.
*/
@property (nonatomic, assign) id<SOMASettingControllerDelegate> delegate;

@end

/*!
	@protocol		SOMASettingControllerDelegate
	
	@abstract		Informational Delegate Protocol.
	@updated		2012-11-12
	@availability	Available since iSoma 4.0 and later.
*/
@protocol SOMASettingControllerDelegate

/*!
	@method			settingViewControllerDismiss:
	@methodgroup    Other

	@abstract       Invoked when the "Back/Done" button has been pressed.
	@param          controller The sender of that message (typically a `SOMASettingController` object).
    @availability	Available since iSoma 4.0 and later.
*/
- (void)settingViewControllerDismiss:(SOMASettingController *)controller;

@end