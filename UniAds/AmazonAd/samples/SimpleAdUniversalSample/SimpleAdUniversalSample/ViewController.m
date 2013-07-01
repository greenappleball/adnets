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
{
    AmazonAdView *_amazonAdView;
}

- (void)loadAmazonAdWithUserInterfaceIdiom:(UIUserInterfaceIdiom)userInterfaceIdiom userInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;
- (IBAction)loadAmazonAd:(UIButton *)sender;


@end

@implementation ViewController
@synthesize loadAdButton;
@synthesize descLabel;
@synthesize lastOrientation;
@synthesize amazonAdView = _amazonAdView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Load an amazon ad and create the AmazonAd view in the process
    [self loadAmazonAd:self.loadAdButton];
    
    // Register the ViewController with the delegate to receive callbacks.
    self.amazonAdView.delegate = self;        
    
}

- (void)viewDidUnload
{
    [self setLoadAdButton:nil];
    [self setDescLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
- (BOOL) shouldAutorotate 
{
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
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

- (void)loadAmazonAdWithUserInterfaceIdiom:(UIUserInterfaceIdiom)userInterfaceIdiom userInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Set the ad options and load the ad
    AmazonAdOptions *options = [AmazonAdOptions options];
    // Test Requests disable metric tracking and typically have a 100% fill rate
    options.isTestRequest = YES;
    
    // IMPORTANT: Create the AmazonAd view for requesting an ad of appropriate size based on the current device and orientation if necessary
    if (userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        if (self.amazonAdView == nil) {
            // Create the Amazon Ad view of size 320x50 for iPhone if we have not already
            self.amazonAdView = [AmazonAdView amazonAdViewWithAdSize:AmazonAdSize_320x50];
        }
    } else {
        // Remove the Amazon Ad view since we may request an ad of different size
        [self.amazonAdView removeFromSuperview];
        
        if (UIInterfaceOrientationIsPortrait(interfaceOrientation)) {
            
            // Create the Amazon Ad view of size 728x90 for iPad while in portrait mode
            self.amazonAdView = [AmazonAdView amazonAdViewWithAdSize:AmazonAdSize_728x90];
            
            // Reposition and resize the Amazon Ad view to center at top
            [self.amazonAdView setFrame:CGRectMake((self.view.bounds.size.width - 728.0) / 2.0, 0.0, 728.0, 90.0)];
        } else {
           
            // Create the Amazon Ad view of size 1024x50 for iPad while in landscape mode
            self.amazonAdView = [AmazonAdView amazonAdViewWithAdSize:AmazonAdSize_1024x50];
           
            // Reposition and resize the Amazon Ad view to center at top
            [self.amazonAdView setFrame:CGRectMake((self.view.bounds.size.width - 1024.0) / 2.0, 0.0, 1024.0, 50.0)];
        }
        
        // Add the newly created Amazon Ad view to our view.
        [self.view addSubview:self.amazonAdView];
        
        // Register the ViewController with the delegate to receive callbacks.
        self.amazonAdView.delegate = self;
    }
    
    // Load an amazon ad with the given options
    [self.amazonAdView loadAd:options];
    self.amazonAdView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
}

- (IBAction)loadAmazonAd:(UIButton *)sender
{
    // Load an amazon ad based on the current device and orientation
    [self loadAmazonAdWithUserInterfaceIdiom:[[UIDevice currentDevice] userInterfaceIdiom] userInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
}


- (void)dealloc {
    [_amazonAdView release];
    [loadAdButton release];
    [descLabel release];
    [super dealloc];
}


#pragma mark AmazonAdViewDelegate

- (UIViewController *)viewControllerForPresentingModalView
{
    return self;
}

- (void)adViewDidLoad:(AmazonAdView *)view 
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
