//
//  MPAppLovinInterstitialAdapter.m
//  
//
//  Created by Dmitri Petrishin on 6/17/13.
//
//

#import "MPAppLovinInterstitialAdapter.h"


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
        UIWindow * window = rootViewController.view.window;
        UIInterfaceOrientation currentOrientation = [[UIDevice currentDevice] orientation];
        
        CGRect localFrame;
        
        if(currentOrientation == UIDeviceOrientationPortrait || currentOrientation == UIDeviceOrientationPortraitUpsideDown)
        {
            localFrame = CGRectMake(0, 0, window.frame.size.width, window.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height);
        }
        else
        {
            localFrame = CGRectMake(0, 0, window.frame.size.width - [UIApplication sharedApplication].statusBarFrame.size.width, window.frame.size.height);
        }
        
        _interstitialAd = [[ALInterstitialAd alloc] initWithFrame:localFrame];
        _interstitialAd.adDisplayDelegate = self;
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
}

-(void)ad:(ALAd *)ad wasClickedIn:(UIView *)view
{
    MPLogInfo(@"AppLovin interstitial was clicked");
}

- (void)dealloc
{
    _interstitialAd.adDisplayDelegate = nil;
    _interstitialAd = nil;
    _loadedAd = nil;
}

@end
