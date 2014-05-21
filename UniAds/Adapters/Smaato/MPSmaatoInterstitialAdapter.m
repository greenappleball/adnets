//
//  MPSmaatoInterstitialAdapter.m
//  Pods
//
//  Created by Dmitri Petrishin on 9/16/13.
//
//

#import "MPSmaatoInterstitialAdapter.h"
#import "SmaatoAdapterData.h"
#import <iSoma.h>
#import "MPLogging.h"

@interface UIView(MPSmaatoHacks)

@end

@implementation UIView(MPSmaatoHacks)

- (void) MPSmaato_recursiveSubviewsEnumerateWithBlock:(void (^)(UIView* subview, BOOL* shouldFinish))block {
    for (UIView* v in self.subviews) {
        if (block) {
            BOOL shouldFinish = NO;
            block(v,&shouldFinish);
            if (shouldFinish) {
                return;
            }
        }
        [v MPSmaato_recursiveSubviewsEnumerateWithBlock:block];
    }
}

@end

@interface MPSmaatoInterstitialAdapter ()

@property(strong, nonatomic) SOMAInterstitialBannerView* interstitialBannerView;

@end

@implementation MPSmaatoInterstitialAdapter

#pragma mark - super

- (void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info
{
    MPLogInfo(@"Requesting Smaato interstitial...");
    SmaatoAdapterData* params = [SmaatoAdapterData dataWithInfo:info];
    // Test mode
//    self.params.isTestMode = @"yes";
    self.interstitialBannerView = [[SOMAInterstitialBannerView alloc] initWithPublisherID:[params.publisherId integerValue] adSpaceID:[params.spaceId integerValue]];
    CGRect frame = [[[UIApplication sharedApplication] delegate] window].rootViewController.view.bounds;
#ifdef __IPHONE_7_0
#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
    if (![[UIApplication sharedApplication] isStatusBarHidden] && floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
        frame.origin.y = 20;
        frame.size.height-=20;
    }
#endif
#endif
#endif
    self.interstitialBannerView.frame = frame;

    self.interstitialBannerView.adType = kSOMAAdTypeAll;
    [self.interstitialBannerView setAutoresizesSubviews:YES];
    self.interstitialBannerView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    __weak __typeof(&*self)weakSelf = self;
    [self.interstitialBannerView asyncLoadInterstitialWithCompletionHandler:^(id<SOMAReceivedBanner> receivedBanner, NSError *error) {
        if (error) {
            MPLogInfo(@"\nSmaato error interstitial ad retrieval: %@", [error localizedDescription]);
            [weakSelf.delegate interstitialCustomEvent:weakSelf didFailToLoadAdWithError:error];
        // Pass richmedia ads - stay visible after closing
        } else if (kSOMAAdTypeRichMedia == [receivedBanner adType]) {
            MPLogInfo(@"\nSmaato interstitial ad retrieval RichMedia - pass interstitial");
            [weakSelf.delegate interstitialCustomEvent:weakSelf didFailToLoadAdWithError:nil];
        } else {
            MPLogInfo(@"\nSmaato has successfully loaded a new interstitial ad.");
            [weakSelf.delegate interstitialCustomEvent:weakSelf didLoadAd:nil];
        }
    }];
}

- (void)showInterstitialFromRootViewController:(UIViewController *)rootViewController
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [rootViewController.view addSubview:self.interstitialBannerView];
    [self.interstitialBannerView MPSmaato_recursiveSubviewsEnumerateWithBlock:^(UIView* subview, BOOL* shouldFinish) {
        if ([subview isKindOfClass:[SOMABannerView class]] || [subview isKindOfClass:[UIWebView class]]) {
            subview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            subview.frame = subview.superview.bounds;
        }
    }];
    // SOMAInterstitialBannerView not have callback of close action
    // therefore need to say what mopub sdk can load new ads
    [self.delegate interstitialCustomEventWillDisappear:self];
    [self.delegate interstitialCustomEventDidDisappear:self];
}

@end
