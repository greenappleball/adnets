//
//  MPAmazonAdEventAdapter.m
//  Pods
//
//  Created by Dmitri Petrishin on 7/1/13.
//
//

#import <AmazonAd/AmazonAdRegistration.h>
#import <AmazonAd/AmazonAdView.h>
#import <AmazonAd/AmazonAdError.h>
#import <AmazonAd/AmazonAdOptions.h>
#import "MPAmazonAdEventAdapter.h"
#import "MPLogging.h"


#pragma mark - Ad definitions

#define AD_DOMAIN               @"com.AmazonAd_iOS_SDK"
#define kAppId   @"appId"
#define kIsTestMode @"isTestMode"

@interface MPAmazonAdEventAdapter () <AmazonAdViewDelegate> {
    AmazonAdView* _adBannerView;
}

@property (readonly, nonatomic) NSString* appId;
@property (strong, nonatomic) NSDictionary* mopubInfo;
@property (assign, nonatomic) UIInterfaceOrientation lastOrientation;

@end


@implementation MPAmazonAdEventAdapter

- (NSString *)appId
{
    NSString* appId = self.mopubInfo[kAppId];
    return appId ? : @"sample-app-v1_pub-2";
}

#pragma	mark - Private

- (NSError*) errorWithCode:(NSInteger)code userInfo:(NSDictionary*)info {
    NSDictionary* userInfo = [info isKindOfClass:[NSDictionary class]] ? info : [NSDictionary dictionary];
    return [NSError errorWithDomain:AD_DOMAIN code:code userInfo:userInfo];
}

- (CGSize)sizeByIdiom:(UIUserInterfaceIdiom)userInterfaceIdiom forOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    CGSize size = AmazonAdSize_320x50;
    if (UIUserInterfaceIdiomPhone != userInterfaceIdiom) {
        size = AmazonAdSize_728x90;//UIInterfaceOrientationIsPortrait(interfaceOrientation) ? AmazonAdSize_728x90 : AmazonAdSize_1024x50;
    }
    return size;
}

- (void)loadAmazonAd
{
    AmazonAdOptions *options = [AmazonAdOptions options];
    if (self.mopubInfo[kIsTestMode]) {
        options.isTestRequest = YES;
    }
    _adBannerView.delegate = self;
    [_adBannerView loadAd:options];
}

#pragma	mark - super

- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info
{
    self.mopubInfo = info;

    // Register the app ID
    [[AmazonAdRegistration sharedRegistration] setApplicationId:self.appId];
    [[AmazonAdRegistration sharedRegistration] setLogging:YES];

    CGSize amazonSize = [self sizeByIdiom:[[UIDevice currentDevice] userInterfaceIdiom] forOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    _adBannerView = [AmazonAdView amazonAdViewWithAdSize:amazonSize];
    _adBannerView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;

    [self loadAmazonAd];
}

#pragma mark AmazonAdViewDelegate

- (UIViewController *)viewControllerForPresentingModalView
{
    if ([self.delegate respondsToSelector:@selector(viewControllerForPresentingModalView)]) {
        return [self.delegate viewControllerForPresentingModalView];
    }
    return nil;
}

- (void) adViewDidLoad:(AmazonAdView *)view
{
    MPLogInfo(@"Successfully loaded banner AmazonAd");
    [self.delegate bannerCustomEvent:self didLoadAd:_adBannerView];
}

- (void)adViewDidFailToLoad:(AmazonAdView *)view withError:(AmazonAdError *)error
{
    MPLogInfo(@"AmazonAd Failed to load. Error code %d: %@", error.errorCode, error.errorDescription);
    NSError* err = [self errorWithCode:error.errorCode userInfo:@{@"userInfo":error.errorDescription}];
    [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:err];
}

- (void)adViewWillExpand:(AmazonAdView *)view
{
    MPLogInfo(@"AmazonAd banner will present modal");
    [self.delegate bannerCustomEventWillBeginAction:self];
}

- (void)adViewDidCollapse:(AmazonAdView *)view
{
    MPLogInfo(@"AmazonAd banner did dismiss modal");
    [self.delegate bannerCustomEventDidFinishAction:self];
}

@end
