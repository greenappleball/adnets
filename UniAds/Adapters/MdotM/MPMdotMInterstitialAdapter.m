//
//  MPMdotMInterstitialAdapter.m
//  Pods
//
//  Created by Dmitri Petrishin on 9/2/13.
//
//

#import "MPLogging.h"
#import "MdotMAdapterData.h"
#import "MdotMRequestParameters.h"
#import "MPMdotMInterstitialAdapter.h"

@interface MPMdotMInterstitialAdapter ()
@property (strong, nonatomic) MdotMInterstitial* interstitialAd;
@property (strong, nonatomic) MdotMRequestParameters* requestParameters;
@end

@implementation MPMdotMInterstitialAdapter

- (MdotMRequestParameters *)requestParameters
{
    if (nil == _requestParameters) {
        _requestParameters = [MdotMRequestParameters new];
    }
    return _requestParameters;
}

- (MdotMInterstitial *)interstitialAd
{
    if (nil == _interstitialAd) {
        _interstitialAd = [MdotMInterstitial new];
        _interstitialAd.interstitialDelegate = self;
    }
    return _interstitialAd;
}

#pragma mark - MPInterstitialCustomEvent Subclass Methods

- (void)dealloc
{
    self.interstitialAd.interstitialDelegate = nil;
    self.requestParameters = nil;
    self.interstitialAd = nil;
}

- (void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info
{
    MPLogInfo(@"Requesting interstitial...\n,%@", info?:[MPMdotMInterstitialAdapter description]);
    MdotMAdapterData* params = [MdotMAdapterData dataWithInfo:info];
    self.requestParameters.appKey = params.key;
    self.requestParameters.test = params.test;
    [self.interstitialAd loadInterstitialAd:self.requestParameters];
}

- (void)showInterstitialFromRootViewController:(UIViewController *)rootViewController
{
    [self.interstitialAd showInterstitial:rootViewController animated:YES];
    [self.delegate interstitialCustomEventDidAppear:self];
}

#pragma mark - MdotMInterstitialDelegate methods

-(void) onReceiveInterstitialAd {
    MPLogInfo(@"Successfully loaded MdotM interstitial.");
    [self.delegate interstitialCustomEvent:self didLoadAd:nil];
}

-(void) onReceiveInterstitialAdError:(NSString *)error
{
    MPLogInfo(@"Failed to load MdotM interstitial: %@", error);
    NSError* err = [NSError errorWithDomain:AD_DOMAIN code:1000 userInfo:@{NSLocalizedDescriptionKey: error}];
    [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:err];
}

-(void) onReceiveClickInInterstitialAd
{
    [self.delegate interstitialCustomEventDidReceiveTapEvent:self];
}

-(void) willShowModalViewController
{
    [self.delegate interstitialCustomEventWillAppear:self];
}

-(void) didShowModalViewController
{
    [self.delegate interstitialCustomEventDidAppear:self];
}

-(void) willDismissModalViewController
{
    [self.delegate interstitialCustomEventWillDisappear:self];
}

-(void) didDismissModalViewController
{
    [self.delegate interstitialCustomEventDidDisappear:self];
}

-(void) willLeaveApplication
{
    [self.delegate interstitialCustomEventWillLeaveApplication:self];
}

@end