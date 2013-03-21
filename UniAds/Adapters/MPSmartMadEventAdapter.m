//
//  MPCustomEventAdapter.m
//  
//
//  Created by Dmitri Petrishin on 1/23/12.
//  Copyright (c) 2012 Postindustria. All rights reserved.
//

#import "MPSmartMadEventAdapter.h"
#import "MPLogging.h"

#pragma mark - Ad definitions

#define AD_DOMAIN               @"com.smartmad.SmartMad_iOS_SDK"

#define kAppID      @"id"
#define kBanner1    @"banner1"
#define kBanner2    @"banner2"
#define kIdiom      @"idiom"
#define vPhoneIdiom @"phone"

@interface MPSmartMadEventAdapter () {
    SMAdBannerView* _adBannerView;
}

@property(retain, nonatomic) NSDictionary* params;

@end

#pragma mark - Implementation

@implementation MPSmartMadEventAdapter

- (void)dealloc {
    [self releaseBannerViewDelegateSafely];
    self.params = nil;
	[super dealloc];
}

#pragma	mark - Private

- (NSError*) errorWithCode:(NSInteger)code userInfo:(NSDictionary*)info {
    NSDictionary* userInfo = [info isKindOfClass:[NSDictionary class]] ? info : [NSDictionary dictionary];
    return [NSError errorWithDomain:AD_DOMAIN code:code userInfo:userInfo];
}

- (void)releaseBannerViewDelegateSafely {
    [_adBannerView setDelegate:nil];
    [_adBannerView release];
    _adBannerView = nil;
}

- (BOOL)is_iPad
{
    NSString* idiom = self.params[kIdiom];
    return (idiom && [idiom isEqualToString:vPhoneIdiom]);
}

#pragma	mark - super

- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info
{
    self.params = info;
    [self loadSmartMadSDK];
}

#pragma	mark - SmartMad setup

- (void)setupSMAdManager
{
    [SMAdManager setAdRefreshInterval:[self adInterval]];
    [SMAdManager setApplicationId:[self adAppId]];
    BOOL isDebug = NO;
#ifdef DEBUG
    isDebug = YES;
#endif
    [SMAdManager setDebugMode:isDebug];
}

- (void)setupSMAdBannerWithSizeType:(SMAdBannerSizeType)sizeType
{
    _adBannerView = [[SMAdBannerView alloc] initWithAdSpaceId:[self adPositionId] smAdSize:sizeType];
    _adBannerView.rootViewController = [self.delegate viewControllerForPresentingModalView];
    _adBannerView.backgroundColor = [UIColor clearColor];
    [_adBannerView setDelegate:self];
}

#pragma	mark - Custom selector

- (void)loadSmartMadSDK
{
    // SmartMad id should set befor initing view
    [self setupSMAdManager];
    
    // init SmartMad's view
    SMAdBannerSizeType measureType = [self adMeasure];
    [self setupSMAdBannerWithSizeType:measureType];
}

#pragma	mark - SmartMadDelegate

-(NSString*)adAppId {
    NSString* result = self.params[kAppID];
    NSString* iPadFlipClockId = @"e5eee68390816c19";
    return nil != result ? result : iPadFlipClockId;
}

-(NSString*)adPositionId {
    NSString* result = self.params[kBanner1];
    NSString* iPadFlipClockBanner1 = @"90014245";
    return nil != result ? result : iPadFlipClockBanner1;
}

-(NSTimeInterval)adInterval {
    // Default 60 Seconds
    NSTimeInterval timeInterval = 60;
#ifdef DEBUG
    timeInterval = 10;
#endif
    return timeInterval;
}

-(SMAdBannerSizeType)adMeasure{
    SMAdBannerSizeType result = PHONE_AD_BANNER_MEASURE_AUTO;
    if ([self is_iPad]) {
        result = TABLET_AD_BANNER_MEASURE_728X90;
    }
    return result;
}

-(BannerAnimationType)adBannerAnimation {
    BannerAnimationType animationType = BannerAnimation_None;
    return animationType;
}

#pragma SMAdBannerViewDelegate

- (void)adBannerViewDidReceiveAd:(SMAdBannerView*)adView{
    MPLogInfo(@"SmartMad has successfully loaded a new ad.");
    [self.delegate bannerCustomEvent:self didLoadAd:_adBannerView];
}

- (void)adBannerView:(SMAdBannerView*)adView didFailToReceiveAdWithError:(SMAdEventCode*)errorCode{
    MPLogInfo(@"SmartMad failed in trying to load or refresh an ad.");
    NSError* error = [self errorWithCode:errorCode.code userInfo:[NSDictionary dictionaryWithObject:@"Invalid Ad" forKey:@"userInfo"]];
    [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:error];
}

- (void)adBannerViewWillPresentScreen:(SMAdBannerView*)adView{
}

- (void)adBannerViewWillDismissScreen:(SMAdBannerView*)adView{
}

- (void)adBannerViewDidDismissScreen:(SMAdBannerView*)adView{
}

- (void)adBannerViewWillLeaveApplication:(SMAdBannerView*)adView{
}

- (void)adDidClick{
}

- (void)adWillExpandAd:(SMAdBannerView *)adView{
}

- (void)adDidCloseExpand:(SMAdBannerView*)adView{
}

- (void)appWillSuspendForAd:(SMAdBannerView*)adView{
}

- (void)appWillResumeFromAd:(SMAdBannerView*)adView{
}

@end
