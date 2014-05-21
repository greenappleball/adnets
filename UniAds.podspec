Pod::Spec.new do |s|
  s.name = 'UniAds'
  s.version = '3.4.3'
  s.platform = :ios, '5.0'
  s.license = {:type => 'commercial',:text =>'text goes here'}
  s.summary = 'An unofficial clone of some ad SDK for iOS.'
  s.author = {'PI' => 'support@pi.com'}
  s.source = {:git => 'ssh://git@git.postindustria.com/adnets.git', :tag => '3.4.3'}
  s.homepage = 'https://developers.google.com/mobile-ads-sdk/download#downloadios'
#  s.source_files  = 'UniAds/*.*'
  s.preserve_paths = 'UniAds/Adapters'

  s.default_subspec = 'Base'
#
# Preferred subspec: fix adding the pod to git repos
#
  s.subspec 'Base' do |ss|
    ss.source_files  = 'UniAds/Adapters/*.{h,m,c,mm}'
    ss.dependency 'UniAds/OneLouderAd'
    ss.dependency 'UniAds/iAd'
    ss.requires_arc = true
  end

  s.subspec 'Pro' do |ss|
    ss.dependency 'UniAds/Base'
    ss.dependency 'UniAds/MdotM'
    ss.dependency 'UniAds/Smaato'
  end

  s.subspec 'All' do |ss|
    ss.dependency 'UniAds/Pro'
    ss.dependency 'UniAds/SmartMad'
    ss.dependency 'UniAds/AppLovin'
    ss.dependency 'UniAds/FlurryAds'
    ss.dependency 'UniAds/VunglePub'
    ss.dependency 'UniAds/AmazonAd'
    ss.dependency 'UniAds/InMobiAdapter'
    ss.dependency 'UniAds/AppSponsor'
  end

#
# Custom Adapters
#
  s.subspec 'SmartMadAdapter' do |ss|
    ss.source_files = 'UniAds/Adapters/SmartMad/*.*'
    ss.requires_arc = true
  end

  s.subspec 'SmaatoAdapter' do |ss|
    ss.source_files = 'UniAds/Adapters/Smaato/*.*'
    ss.requires_arc = true
  end

  s.subspec 'MdotMAdapter' do |ss|
    ss.source_files = 'UniAds/Adapters/MdotM/*.*'
    ss.requires_arc = true
  end

  s.subspec 'AppLovinAdapter' do |ss|
    ss.source_files = 'UniAds/Adapters/AppLovin/*.*'
    ss.requires_arc = true
  end

  s.subspec 'FlurryAdsAdapter' do |ss|
    ss.source_files = 'UniAds/Adapters/FlurryAds/*.*'
    ss.requires_arc = true
  end

  s.subspec 'VunglePubAdapter' do |ss|
    ss.source_files = 'UniAds/Adapters/VunglePub/*.*'
    ss.requires_arc = true
  end

  s.subspec 'AmazonAdAdapter' do |ss|
    ss.source_files = 'UniAds/Adapters/Amazon/*.*'
    ss.requires_arc = true
  end

  s.subspec 'OneLouderAdAdapter' do |ss|
    ss.source_files = 'UniAds/Adapters/OneLouderAd/*.*'
    ss.requires_arc = true
  end

  s.subspec 'InMobiAdapter' do |ss|
    ss.source_files = 'UniAds/Adapters/InMobi/*.*'
    ss.requires_arc = true
    ss.dependency 'InMobiSDK'
  end

  s.subspec 'AppSponsorAdapter' do |ss|
    ss.source_files = 'UniAds/Adapters/AppSponsor/*.*'
    ss.requires_arc = true
  end

#
# Ads Networks specifications
#
  s.subspec 'iAd' do |ss|
    ss.dependency 'mopub-ios-sdk/iAd'
    ss.frameworks = 'iAd'
  end

  s.subspec 'AdMob' do |ss|
    ss.frameworks = 'AudioToolbox', 'MessageUI', 'SystemConfiguration', 'CoreGraphics', 'AdSupport', 'StoreKit'
    ss.dependency 'mopub-ios-sdk/AdMob'
  end

  s.subspec 'MMSDK' do |ss|
#    ss.frameworks = 'QuartzCore','MediaPlayer','CoreGraphics','CoreLocation','MobileCoreServices','AudioToolbox','AVFoundation','SystemConfiguration','UIKit','Foundation'
#    ss.dependency 'mopub-ios-sdk/MillenialAdapter'
  end

  s.subspec 'SmartMad' do |ss|
    ss.source_files = 'UniAds/SmartMad/*.h'
    ss.resources    = 'UniAds/SmartMad/*.{png,bundle}'
    ss.preserve_paths = '**/*.a'
    ss.library = 'SmartMad','z'
    ss.frameworks = 'AudioToolbox','AdSupport','CoreLocation','CoreMotion','CoreTelephony','AVFoundation','QuartzCore','MediaPlayer','StoreKit','SystemConfiguration','CFNetwork','MessageUI','EventKit','EventKitUI'
    ss.xcconfig  =  { 'LIBRARY_SEARCH_PATHS' => '"$(SRCROOT)/Pods/UniAds/UniAds/SmartMad"' }
    ss.dependency 'UniAds/SmartMadAdapter'
  end

  s.subspec 'MdotM' do |ss|
    ss.source_files = 'UniAds/MdotM/*.h'
    ss.preserve_paths = '**/*.a'
    ss.library = 'MdotMSDK2','z','xml2'
    ss.frameworks = 'SystemConfiguration','MobileCoreServices','CFNetwork','UIKit','Foundation','CoreGraphics','MediaPlayer','QuartzCore','AdSupport'
    ss.xcconfig  =  { 'LIBRARY_SEARCH_PATHS' => '"$(SRCROOT)/Pods/UniAds/UniAds/MdotM"' }
    ss.dependency 'UniAds/MdotMAdapter'
#    ss.dependency 'ASIHTTPRequest'
  end

  s.subspec 'Smaato' do |ss|
    ss.source_files = 'UniAds/Smaato/Headers/*.h'
    ss.resources    = 'UniAds/Smaato/Resources/**/*.{strings}'
    ss.dependency 'UniAds/SmaatoAdapter'
  end

  s.subspec 'AppLovin' do |ss|
    ss.source_files = 'UniAds/AppLovin/headers/*.h'
    ss.preserve_paths = '**/*.a'
    ss.library = 'AppLovinSdk'
    ss.frameworks = 'AdSupport','CoreTelephony','CoreGraphics','MediaPlayer','SystemConfiguration','StoreKit'
    ss.xcconfig  =  { 'LIBRARY_SEARCH_PATHS' => '"$(SRCROOT)/Pods/UniAds/UniAds/AppLovin"' }
    ss.dependency 'UniAds/AppLovinAdapter'
  end

  s.subspec 'FlurryAds' do |ss|
    ss.dependency 'FlurrySDK/FlurryAds'
    ss.dependency 'UniAds/FlurryAdsAdapter'
  end

  s.subspec 'VunglePub' do |ss|
    ss.source_files = 'UniAds/VunglePub/vunglepub.framework/Headers/*.h'
    ss.resources    = 'UniAds/VunglePub/Resources/*.*'
    ss.preserve_paths = 'UniAds/VunglePub'
    ss.library = 'z'
    ss.frameworks = 'vunglepub','AVFoundation','CFNetwork','CoreGraphics','AudioToolbox','CoreMedia','Foundation','MediaPlayer','QuartzCore','SystemConfiguration','UIKit','AdSupport','StoreKit','CoreLocation'
    ss.xcconfig  =  { 'FRAMEWORK_SEARCH_PATHS' => '"$(PODS_ROOT)/UniAds/UniAds/VunglePub"' }
    ss.dependency 'UniAds/VunglePubAdapter'
  end

  s.subspec 'AmazonAd' do |ss|
    ss.source_files = 'UniAds/AmazonAd/AmazonAd.framework/Headers/*.h'
    ss.preserve_paths = 'UniAds/AmazonAd/AmazonAd.framework'
    ss.frameworks = 'AmazonAd','AdSupport','CoreGraphics','CoreLocation','Foundation','MediaPlayer','QuartzCore','StoreKit','SystemConfiguration','UIKit'
    ss.xcconfig  =  { 'FRAMEWORK_SEARCH_PATHS' => '"$(PODS_ROOT)/UniAds/UniAds/AmazonAd"' }
    ss.dependency 'UniAds/AmazonAdAdapter'
  end

  s.subspec 'OneLouderAd' do |ss|
    ss.source_files = 'UniAds/OLAdKitSDK/*.{h,m}'
    ss.resources    = 'UniAds/OLAdKitSDK/*.{png,bundle}'
    ss.preserve_paths = '**/*.a'
    ss.library = 'OLAdKitSDK'
    ss.frameworks = 'StoreKit','AdSupport','AudioToolbox','AVFoundation','CoreLocation','CoreGraphics','EventKit','EventKitUI','MediaPlayer','MobileCoreServices','QuartzCore','SystemConfiguration','Social','Accounts','CoreTelephony','MessageUI','iAd','AssetsLibrary'
    ss.xcconfig  =  { 'LIBRARY_SEARCH_PATHS' => '"$(SRCROOT)/Pods/UniAds/UniAds/OLAdKitSDK"' }

    ss.dependency 'UniAds/OneLouderAdAdapter'
    ss.dependency 'UniAds/Smaato'
    ss.dependency 'UniAds/MMSDK'
    ss.dependency 'UniAds/AdMob'
  end

  s.subspec 'AppSponsor' do |ss|
    ss.source_files = 'UniAds/AppSponsor/AppSponsorSDK.framework/Headers/*.h'
    ss.resources    = 'UniAds/AppSponsor/Resources/*.*'
    ss.preserve_paths = 'UniAds/AppSponsor/AppSponsorSDK.framework'
    ss.library = 'z','stdc++'
    ss.frameworks = 'AppSponsorSDK','AudioToolbox','QuartzCore','OpenGLES','Security','CFNetwork','SystemConfiguration','CoreMotion','CoreGraphics','UIKit','Foundation'
    ss.weak_frameworks = 'AdSupport','CoreLocation','StoreKit','Accelerate'
    ss.xcconfig  =  { 'FRAMEWORK_SEARCH_PATHS' => '"$(PODS_ROOT)/UniAds/UniAds/AppSponsor"' }
    ss.dependency 'UniAds/AppSponsorAdapter'
  end

  s.dependency 'mopub-ios-sdk'

end
