//
//  SOMAFullScreenBannerDelegate.h
//  iSoma
//
//  Created by Bilge Ulusoy on 24.10.12.
//
//

#import <Foundation/Foundation.h>

@protocol SOMABannerViewDelegate;
@class SOMAFullScreenBanner;


@protocol SOMAFullScreenBannerDelegate <SOMABannerViewDelegate>

@optional
- (void)fullScreenBannerWillDismiss:(SOMAFullScreenBanner *)aBanner;
- (void)fullScreenBannerDidDismiss:(SOMAFullScreenBanner *)aBanner;
- (void)fullScreenBannerWillPresent:(SOMAFullScreenBanner *)aBanner;
- (void)fullScreenBannerDidPresent:(SOMAFullScreenBanner *)aBanner;
- (void)fullScreenBannerDidOpenLandingPage:(SOMAFullScreenBanner *)aBanner;


@end

