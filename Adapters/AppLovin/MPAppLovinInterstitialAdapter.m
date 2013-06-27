//
//  MPAppLovinInterstitialAdapter.m
//  
//
//  Created by Dmitri Petrishin on 6/17/13.
//
//

#import "MPAppLovinInterstitialAdapter.h"
#import "MPLogging.h"


@implementation MPAppLovinInterstitialAdapter

- (void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info
{
    MPLogInfo(@"Requesting AppLovin interstitial...");
    
    ALAdService * adService = [[ALSdk shared] adService];
    [adService loadNextAd: [ALAdSize sizeInterstitial]
                 placedAt: nil
                andNotify: self];
}
 
- (void)showInterstitialFromRootViewController:(UIViewController *)rootViewController
{
    if (_loadedAd)
    {
        CGRect localFrame = rootViewController.view.frame;
        _interstitialAd = [[ALInterstitialAd alloc] initWithFrame:localFrame];
        _interstitialAd.adDisplayDelegate = self;
        UIWindow * window = rootViewController.view.window;
        [_interstitialAd showOver:window andRender:_loadedAd];
    }
    else
    {
        MPLogInfo(@"Failed to show AppLovin interstitial: no ad loaded");
        
        [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:nil];
    }
}

#pragma mark - ALAdLoadDelegate methods

-(void)adService:(ALAdService *)adService didLoadAd:(ALAd *)ad
{
    MPLogInfo(@"Successfully loaded AppLovin interstitial.");
    
    // Save the newly loaded ad
    _loadedAd = ad;
    
    [self.delegate interstitialCustomEvent:self didLoadAd:ad];
}

-(void)adService:(ALAdService *)adService didFailToLoadAdWithError:(int)code
{
    MPLogInfo(@"Failed to load AppLovin interstitial: %i", code);
    
    [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:nil];
}


#pragma mark - ALAdDisplayDelegate methods

-(void)ad:(ALAd *)ad wasHiddenIn:(UIView *)view
{
    MPLogInfo(@"AppLovin interstitial was dismissed");
    
    [self.delegate interstitialCustomEventDidDisappear:self];
}


-(void)ad:(ALAd *)ad wasDisplayedIn:(UIView *)view
{
    MPLogInfo(@"AppLovin interstitial was displayed");
    [self.delegate interstitialCustomEventDidAppear:self];
}

-(void)ad:(ALAd *)ad wasClickedIn:(UIView *)view
{
    MPLogInfo(@"AppLovin interstitial was clicked");
    [self.delegate interstitialCustomEventDidReceiveTapEvent:self];
}

- (void)dealloc
{
    _interstitialAd.adDisplayDelegate = nil;
    _interstitialAd = nil;
    _loadedAd = nil;
}

@end
