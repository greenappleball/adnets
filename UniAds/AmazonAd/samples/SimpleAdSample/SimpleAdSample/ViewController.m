// Copyright 2012 Amazon.com, Inc. or its affiliates. All Rights Reserved.
// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.
// A copy of the License is located at http://aws.amazon.com/apache2.0/
// or in the "license" file accompanying this file.
// This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. 
// See the License for the specific language governing permissions and
// limitations under the License.

#import <AmazonAd/AmazonAdView.h>
#import <AmazonAd/AmazonAdOptions.h>
#import <AmazonAd/AmazonAdError.h>
#import "ViewController.h"

@interface ViewController ()<AmazonAdViewDelegate>

- (IBAction)loadAmazonAd:(UIButton *)sender;

@property (nonatomic, retain) AmazonAdView *amazonAdView;

@end

@implementation ViewController
@synthesize loadAdButton;
@synthesize textDesc;
@synthesize amazonAdView;
@synthesize lastOrientation;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Create an AmazonAdView instance with size 320x50.
    self.amazonAdView = [AmazonAdView amazonAdViewWithAdSize:AmazonAdSize_320x50];
    self.amazonAdView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    // Register the ViewController with the delegate to receive callbacks.
    self.amazonAdView.delegate = self;
    
    // Load an ad
    [self loadAmazonAd:self.loadAdButton];
}

- (void)viewDidUnload
{
    [self setLoadAdButton:nil];
    [self setTextDesc:nil];
    [self setAmazonAdView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL) shouldAutorotate 
{
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Backwards compatibility with iOS 4.3 and 5.x
    return YES;
}
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
    // Set appropriate layouts for different device orientations
    [super willAnimateRotationToInterfaceOrientation:interfaceOrientation duration:duration];
    // Reload Amazon Ad upon rotation ­
    // Important Amazon expandable rich media ads target landscape and portrait mode separately
    // If your app supports device rotation events, your app must reload the ad when rotating between portrait and landscape mode
    [self loadAmazonAd: self.loadAdButton];
    
}

- (void)dealloc {
    [loadAdButton release];
    [textDesc release];
    [super dealloc];
}
- (IBAction)loadAmazonAd:(UIButton *)sender
{
    //Set the ad options and load the ad
    AmazonAdOptions *options = [AmazonAdOptions options];
    // Test Requests disable metric tracking and typically have a 100% fill rate
    options.isTestRequest = YES;
    [self.amazonAdView loadAd:options];
}

#pragma mark AmazonAdViewDelegate

- (UIViewController *)viewControllerForPresentingModalView
{
    return self;
}

- (void) adViewDidLoad:(AmazonAdView *)view 
{
    [self.view addSubview:self.amazonAdView];
    NSLog(@"Ad loaded");
}

- (void)adViewDidFailToLoad:(AmazonAdView *)view withError:(AmazonAdError *)error
{
    NSLog(@"Ad Failed to load. Error code %d: %@", error.errorCode, error.errorDescription);
}

- (void)adViewWillExpand:(AmazonAdView *)view
{
    NSLog(@"Ad will expand");
    // Save orientation so when our ad collapses we can reload an ad
    // Also useful if you need to programmatically rearrange view on orientation change
    lastOrientation = [[UIApplication sharedApplication] statusBarOrientation];
}
          
- (void)adViewDidCollapse:(AmazonAdView *)view
{
    NSLog(@"Ad has collapsed");
    // Check for if the orientation has changed while the view disappeared.
    if (lastOrientation != [[UIApplication sharedApplication] statusBarOrientation]) {
        [self loadAmazonAd:self.loadAdButton];
    }
}

@end
