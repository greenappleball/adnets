//
//  RFMSupportedMediations.m
//  MBSAdSDK
//
//  Created by The Rubicon Project on 2/26/13.
//  Copyright (c) 2013 Rubicon Project. All rights reserved.
//

#import "RFMSupportedMediations.h"
#import "MBSUtils.h"

@implementation RFMSupportedMediations



@synthesize supportedMediations = _supportedMediations;
@synthesize mediationMap = _mediationMap;

+ (RFMSupportedMediations *)sharedInstance {
    static RFMSupportedMediations *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[RFMSupportedMediations alloc] init];
    });
    
    return _sharedInstance;
}



-(id)init{
    self = [super init];
    if(!self){
        return nil;
    }
    
    ////Must include only the 3rd party SDKs you are integrating with
    NSArray *mediationTypesAllowed = [[NSArray alloc] initWithObjects:
                                      kMediationTypeRfm,
                                      kMediationTypeMraid,
                                      kMediationTypeRfmCaching,
//                                      kMediationTypeAdmob,
//                                      kMediationTypeDFP,
                                      nil];
    
    _supportedMediations = [mediationTypesAllowed retain];
    [mediationTypesAllowed release];
    
    
    NSDictionary *localMediationMap = [[NSDictionary alloc] initWithObjects:
                                       [NSArray arrayWithObjects:kMediationClassNameRfm,
                                        kMediationClassNameMraid,
                                        kMediationClassNameRfmCaching,
//                                        @"AdmobApiMediator",
//                                        @"DFPApiMediator",
                                        nil]
                                                                    forKeys:_supportedMediations];
    
    _mediationMap = [localMediationMap retain];
    [localMediationMap release];
    
    return self;
    
}



-(void)dealloc{
    [_mediationMap release];
    [_supportedMediations release];
    
    [super dealloc];
}

-(BOOL) isRFMMediationSupported:(NSString *)mediationType
{
    BOOL isSupported = NO;
    
    if([_supportedMediations containsObject:mediationType]){
        isSupported = YES;
    }
    
    return isSupported;
}


-(Class)mediatorClassForMediationType:(NSString *)mediationType{
    if ([self isRFMMediationSupported:mediationType]) {
        return NSClassFromString([self.mediationMap objectForKey:mediationType]);
    }else{
        return nil;
    }
}

@end
