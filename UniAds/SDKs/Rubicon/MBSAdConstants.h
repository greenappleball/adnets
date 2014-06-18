//
//  MBSAdConstants.h
//  MBSAdSDK
//
//  Created by The Rubicon Project on 5/10/12.
//  Copyright (c) 2012 The Rubicon Project Inc. All rights reserved.
//

#ifndef MBSAdSDK_MBSAdConstants_h
#define MBSAdSDK_MBSAdConstants_h

#pragma mark -
#pragma mark Ad Banner Size and Location

//Macros for specifying ad location:
//Coordinates: note that coordinate system used here is with reference to the content view 
//of the calling view controller.
//Common sizes:
//status bar: 20pt
//nav bar: 44pt (portrait mode), 32pt(landscape mode)
//tabbar: 49pt
//for ex,  in portrait view with 320x50 Adunit
//1. if controller has only a status bar(no nav/tabbar)
//    - available view area: 320x460, origin at left bottom of status bar
//2. if controller has a status bar and nav bar (no tab bar):
//    - available view area: 320x416, origin at left bottom of nav bar.
//3. if controller has a status bar and tab bar (no nav bar):
//    - available view area: 320x411, origin at left bottom of status bar.
//4. if controller has a status bar, nav bar and tab bar :
//    - available view area: 320x 367, origin at left bottom of nav bar.
//5. if controller has a nav bar only
//   - available view area: 320x436, origin at left bottom of nav bar
//6. if controller has a tab bar only
//   - available view area: 320x431, origin at left bottom of nav bar
//7. if controller has nav bar and tab bar
//   - available view area: 320x387, origin at left bottom of nav bar
//8. if controller has no status, nav or tab bar
//   - available view area: 320x 480, origin at left bottom of nav bar

//The coordinate selection impacts only if the banner is to be placed anywhere other than top
//Provided below are coordinate macros if the banner is to be placed at the bottom of the content area.

//Available Sizes
#define MBSAD_SIZE_190x190 CGRectMake(0,0,190, 190)

#define MBSAD_SIZE_320x50 CGRectMake(0,0,320, 50)

#define MBSAD_SIZE_300x250 CGRectMake(0,0,300,250)

//Available Centers
//iPhone, iPod centers
//===========================
//For 320x50 iPod,iPhone AdUnit
//===========================
//AD placed at top of view area
#define MBSAD_PORTRAIT_CENTER_320x50_TOP CGPointMake(CGRectGetMidX([[UIScreen mainScreen] bounds]), 25)
#define MBSAD_LANDSCAPE_CENTER_320x50_TOP CGPointMake(CGRectGetMidY([[UIScreen mainScreen] bounds]), 25)

//AD Placed at bottom of view area
//Views with only status bar (coordinate 1)
#define MBSAD_PORTRAIT_CENTER_SB_320x50_BOTTOM CGPointMake(CGRectGetMidX([[UIScreen mainScreen] bounds]), CGRectGetHeight([[UIScreen mainScreen] bounds]) - 45)
#define MBSAD_LANDSCAPE_CENTER_SB_320x50_BOTTOM CGPointMake(CGRectGetMidY([[UIScreen mainScreen] bounds]), CGRectGetWidth([[UIScreen mainScreen] bounds]) - 45)

//Views with status bar and nav bar(coordinate 2)
#define MBSAD_PORTRAIT_CENTER_SBNB_320x50_BOTTOM  CGPointMake(CGRectGetMidX([[UIScreen mainScreen] bounds]), CGRectGetHeight([[UIScreen mainScreen] bounds]) - 89)
#define MBSAD_LANDSCAPE_CENTER_SBNB_320x50_BOTTOM CGPointMake(CGRectGetMidY([[UIScreen mainScreen] bounds]), CGRectGetWidth([[UIScreen mainScreen] bounds]) - 77)


//Views with status bar and tab bar (coordinate 3)
#define MBSAD_PORTRAIT_CENTER_SBTB_320x50_BOTTOM CGPointMake(CGRectGetMidX([[UIScreen mainScreen] bounds]), CGRectGetHeight([[UIScreen mainScreen] bounds]) - 94)
#define MBSAD_LANDSCAPE_CENTER_SBTB_320x50_BOTTOM CGPointMake(CGRectGetMidY([[UIScreen mainScreen] bounds]), CGRectGetWidth([[UIScreen mainScreen] bounds]) - 94)

//Views with status bar, nav bar and tab bar (coordinate 4)
#define MBSAD_PORTRAIT_CENTER_SBNBTB_320x50_BOTTOM CGPointMake(CGRectGetMidX([[UIScreen mainScreen] bounds]), CGRectGetHeight([[UIScreen mainScreen] bounds]) - 138)
#define MBSAD_LANDSCAPE_CENTER_SBNBTB_320x50_BOTTOM CGPointMake(CGRectGetMidY([[UIScreen mainScreen] bounds]), CGRectGetWidth([[UIScreen mainScreen] bounds]) - 126)

//Views with nav bar(coordinate 5)
#define MBSAD_PORTRAIT_CENTER_NB_320x50_BOTTOM CGPointMake(CGRectGetMidX([[UIScreen mainScreen] bounds]), CGRectGetHeight([[UIScreen mainScreen] bounds]) - 69)
#define MBSAD_LANDSCAPE_CENTER_NB_320x50_BOTTOM CGPointMake(CGRectGetMidY([[UIScreen mainScreen] bounds]), CGRectGetWidth([[UIScreen mainScreen] bounds]) - 57)

//Views with tab bar (coordinate 6)
#define MBSAD_PORTRAIT_CENTER_TB_320x50_BOTTOM CGPointMake(CGRectGetMidX([[UIScreen mainScreen] bounds]), CGRectGetHeight([[UIScreen mainScreen] bounds]) - 74)
#define MBSAD_LANDSCAPE_CENTER_TB_320x50_BOTTOM CGPointMake(CGRectGetMidY([[UIScreen mainScreen] bounds]), CGRectGetWidth([[UIScreen mainScreen] bounds]) - 74)

//Views with nav bar and tab bar (coordinate 7)
#define MBSAD_PORTRAIT_CENTER_NBTB_320x50_BOTTOM CGPointMake(CGRectGetMidX([[UIScreen mainScreen] bounds]), CGRectGetHeight([[UIScreen mainScreen] bounds]) - 118)
#define MBSAD_LANDSCAPE_CENTER_NBTB_320x50_BOTTOM CGPointMake(CGRectGetMidY([[UIScreen mainScreen] bounds]), CGRectGetWidth([[UIScreen mainScreen] bounds]) - 106)

//Views with no status bar, nav bar and tab bar (coordinate 8)
#define MBSAD_PORTRAIT_CENTER_NO_SBNBTB_320x50_BOTTOM CGPointMake(CGRectGetMidX([[UIScreen mainScreen] bounds]), CGRectGetHeight([[UIScreen mainScreen] bounds]) - 25)
#define MBSAD_LANDSCAPE_CENTER_NO_SBNBTB_320x50_BOTTOM CGPointMake(CGRectGetMidY([[UIScreen mainScreen] bounds]), CGRectGetWidth([[UIScreen mainScreen] bounds]) - 25)

//iPad Centers
//Common sizes:
//status bar: 20pt
//nav bar: 44pt (portrait mode), 32pt(landscape mode)
//tabbar: 49pt
//for ex,  in portrait view for 320x50 Adunit
//1. if controller has only a status bar(no nav/tabbar)
//    - available view area: 768x1004, origin at left bottom of status bar
//2. if controller has a status bar and nav bar (no tab bar):
//    - available view area: 768x960, origin at left bottom of nav bar.
//3. if controller has a status bar and tab bar (no nav bar):
//    - available view area: 768x955, origin at left bottom of status bar.
//4. if controller has a status bar, nav bar and tab bar :
//    - available view area: 768x 911, origin at left bottom of nav bar.
//5. if controller has a nav bar only
//   - available view area: 768x980, origin at left bottom of nav bar
//6. if controller has a tab bar only
//   - available view area: 768x975, origin at left bottom of nav bar
//7. if controller has nav bar and tab bar
//   - available view area: 768x931, origin at left bottom of nav bar
//8. if controller has no status, nav or tab bar
//   - available view area: 768x 1024, origin at left bottom of nav bar

//===========================
//For 320x50 iPad AdUnit
//===========================
//AD placed at top of view area
#define IPAD_MBSAD_PORTRAIT_CENTER_320x50_TOP CGPointMake(384,25)
#define IPAD_MBSAD_LANDSCAPE_CENTER_320x50_TOP CGPointMake(512,25)

//AD Placed at bottom of view area
//Views with only status bar (coordinate 1)
#define IPAD_MBSAD_PORTRAIT_CENTER_SB_320x50_BOTTOM CGPointMake(384,979)
#define IPAD_MBSAD_LANDSCAPE_CENTER_SB_320x50_BOTTOM CGPointMake(512,723)

//Views with status bar and nav bar(coordinate 2)
#define IPAD_MBSAD_PORTRAIT_CENTER_SBNB_320x50_BOTTOM CGPointMake(384,935)
#define IPAD_MBSAD_LANDSCAPE_CENTER_SBNB_320x50_BOTTOM CGPointMake(512,679)

//Views with status bar and tab bar (coordinate 3)
#define IPAD_MBSAD_PORTRAIT_CENTER_SBTB_320x50_BOTTOM CGPointMake(384,930)
#define IPAD_MBSAD_LANDSCAPE_CENTER_SBTB_320x50_BOTTOM CGPointMake(512,674)

//Views with status bar, nav bar and tab bar (coordinate 4)
#define IPAD_MBSAD_PORTRAIT_CENTER_SBNBTB_320x50_BOTTOM CGPointMake(384,886)
#define IPAD_MBSAD_LANDSCAPE_CENTER_SBNBTB_320x50_BOTTOM CGPointMake(512,630)

//Views with nav bar(coordinate 5)
#define IPAD_MBSAD_PORTRAIT_CENTER_NB_320x50_BOTTOM CGPointMake(384,955)
#define IPAD_MBSAD_LANDSCAPE_CENTER_NB_320x50_BOTTOM CGPointMake(512,699)

//Views with tab bar (coordinate 6)
#define IPAD_MBSAD_PORTRAIT_CENTER_TB_320x50_BOTTOM CGPointMake(384,950)
#define IPAD_MBSAD_LANDSCAPE_CENTER_TB_320x50_BOTTOM CGPointMake(512,694)

//Views with nav bar and tab bar (coordinate 7)
#define IPAD_MBSAD_PORTRAIT_CENTER_NBTB_320x50_BOTTOM CGPointMake(384,906)
#define IPAD_MBSAD_LANDSCAPE_CENTER_NBTB_320x50_BOTTOM CGPointMake(512,650)

//Views with no status bar, nav bar and tab bar (coordinate 8)
#define IPAD_MBSAD_PORTRAIT_CENTER_NO_SBNBTB_320x50_BOTTOM CGPointMake(384,999)
#define IPAD_MBSAD_LANDSCAPE_CENTER_NO_SBNBTB_320x50_BOTTOM CGPointMake(512,743)



//===========================
//For 300x250 iPad AdUnit
//===========================

//AD placed at top of view area
#define IPAD_MBSAD_PORTRAIT_CENTER_300x250_TOP CGPointMake(384,125)
#define IPAD_MBSAD_LANDSCAPE_CENTER_300x250_TOP CGPointMake(512,125)
//AD Placed at bototm of view area
//Views with only status bar (coordinate 1)
#define IPAD_MBSAD_PORTRAIT_CENTER_SB_300x250_BOTTOM CGPointMake(384,879)
#define IPAD_MBSAD_LANDSCAPE_CENTER_SB_300x250_BOTTOM CGPointMake(512,623)

//Views with status bar and nav bar(coordinate 2)
#define IPAD_MBSAD_PORTRAIT_CENTER_SBNB_300x250_BOTTOM CGPointMake(384,835)
#define IPAD_MBSAD_LANDSCAPE_CENTER_SBNB_300x250_BOTTOM CGPointMake(512,579)

//Views with status bar and tab bar (coordinate 3)
#define IPAD_MBSAD_PORTRAIT_CENTER_SBTB_300x250_BOTTOM CGPointMake(384,830)
#define IPAD_MBSAD_LANDSCAPE_CENTER_SBTB_300x250_BOTTOM CGPointMake(512,574)

//Views with status bar, nav bar and tab bar (coordinate 4)
#define IPAD_MBSAD_PORTRAIT_CENTER_SBNBTB_300x250_BOTTOM CGPointMake(384,786)
#define IPAD_MBSAD_LANDSCAPE_CENTER_SBNBTB_300x250_BOTTOM CGPointMake(512,530)

//Views with nav bar(coordinate 5)
#define IPAD_MBSAD_PORTRAIT_CENTER_NB_300x250_BOTTOM CGPointMake(384,855)
#define IPAD_MBSAD_LANDSCAPE_CENTER_NB_300x250_BOTTOM CGPointMake(512,599)

//Views with tab bar (coordinate 6)
#define IPAD_MBSAD_PORTRAIT_CENTER_TB_300x250_BOTTOM CGPointMake(384,850)
#define IPAD_MBSAD_LANDSCAPE_CENTER_TB_300x250_BOTTOM CGPointMake(512,594)

//Views with nav bar and tab bar (coordinate 7)
#define IPAD_MBSAD_PORTRAIT_CENTER_NBTB_300x250_BOTTOM CGPointMake(384,806)
#define IPAD_MBSAD_LANDSCAPE_CENTER_NBTB_300x250_BOTTOM CGPointMake(512,550)

//Views with no status bar, nav bar and tab bar (coordinate 8)
#define IPAD_MBSAD_PORTRAIT_CENTER_NO_SBNBTB_300x250_BOTTOM CGPointMake(384,899)
#define IPAD_MBSAD_LANDSCAPE_CENTER_NO_SBNBTB_300x250_BOTTOM CGPointMake(512,643)




#pragma mark -
#pragma mark RFM Targeting Information

//Available Keys for targeting info
//Use these keys for dictionary returned as part of - (NSDictionary *)targetingInfo delegate function
#define MBS_TARGETING_INFO_KEY_MBS_AGE        @"NBA_AGE"
#define MBS_TARGETING_INFO_KEY_MBS_GENDER     @"NBA_GENDER"
#define MBS_TARGETING_INFO_KEY_MBS_ZIP        @"NBA_ZIP"
#define MBS_TARGETING_INFO_KEY_MBS_DMA        @"NBA_DMA"
#define MBS_TARGETING_INFO_KEY_MBS_INCOME     @"NBA_INCOME"


#pragma mark -
#pragma mark RFM AdType information

#define RFM_ADTYPE_BANNER @"1"         //Type 1 = Banner
#define RFM_ADTYPE_INTERSTITIAL @"2"   //Type 2 = Interstitial

#endif
