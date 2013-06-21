//
//  MPVungleInterstitialAdapter.m
//  
//
//  Created by Dmitri Petrishin on 6/21/13.
//
//

#import "MPLogging.h"
#import "MPVungleInterstitialAdapter.h"



@implementation MPVungleInterstitialAdapter

#pragma mark - MPInterstitialCustomEvent Subclass Methods

- (void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info
{
    MPLogInfo(@"Requesting interstitial...\n,%@", info);
}

- (void)showInterstitialFromRootViewController:(UIViewController *)rootViewController
{
}

@end
