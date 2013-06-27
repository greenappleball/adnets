//
//  MPAppLovinEventAdapter.m
//  
//
//  Created by Dmitri Petrishin on 6/17/13.
//
//

#import "MPAppLovinEventAdapter.h"
#import "MPConstants.h"
#import "MPLogging.h"


@implementation MPAppLovinEventAdapter

#pragma mark - MPBannerCustomEvent Subclass Methods

- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info
{
    MPLogInfo(@"Requesting AppLovin banner...");
    
    if (CGSizeEqualToSize(size, MOPUB_BANNER_SIZE)) {
        _applovinBannerView = [[ALAdView alloc] initBannerAd];
        _applovinBannerView.adLoadDelegate = self;
        
        [_applovinBannerView loadNextAd];
    }
    else
    {
        MPLogInfo(@"Failed to load AppLovin banner: ad size %@ is not supported.",
              NSStringFromCGSize(size));
        
        [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:nil];
    }
}

- (void)dealloc
{
    _applovinBannerView.adLoadDelegate = nil;
    _applovinBannerView = nil;
}

#pragma mark -
#pragma mark ALAdLoadDelegate methods

-(void)adService:(ALAdService *)adService didLoadAd:(ALAd *)ad
{
    MPLogInfo(@"Successfully loaded AppLovin banner");
    
    [self.delegate bannerCustomEvent:self didLoadAd:_applovinBannerView];
    
}

-(void)adService:(ALAdService *)adService didFailToLoadAdWithError:(int)code
{
    MPLogInfo(@"Failed to load AppLovin banner: %i", code);
    
    [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:nil];
}

@end
