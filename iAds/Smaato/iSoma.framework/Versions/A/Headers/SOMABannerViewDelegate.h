//
//  BannerViewDelegate.h
//  SOMADemo
//
//  Created by Gerrit Alves on 01.07.11.
//  Copyright 2011 Smaato Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
#import <Availability.h>

@class SOMABannerView;
@protocol SOMABannerViewDelegate <NSObject>
@optional
- (void)landingPageWillBeDisplayed;
- (void)landingPageHasBeenClosed;
- (BOOL)shouldUseInAppStore; // __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_6_0);
- (void)didLoadInAppStore:(UIViewController *)aStore; // __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_6_0);
- (void)failedToLoadInAppStore:(UIViewController *)aStore error:(NSError *)anError; // __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_6_0);
@end
