Pod::Spec.new do |s|
  s.name = 'UniAds'
  s.version = '3.0.1'
  s.platform = :ios
  s.license = {:type => 'commercial',:text =>'text goes here'}
  s.summary = 'An unofficial clone of some ad SDK for iOS.'
  s.author = {'PI' => 'support@pi.com'}
  s.source = {:git => 'ssh://git@git.postindustria.com/adnets.git'}
  s.homepage = 'https://developers.google.com/mobile-ads-sdk/download#downloadios'
  s.preserve_paths = 'UniAds/Adapters'

  s.preferred_dependency = 'Base'
#
# Preferred subspec: fix adding the pod to git repos
#
  s.subspec 'Base' do |ss|
    ss.dependency 'UniAds/iAd'
    ss.dependency 'UniAds/OneLouderAd'
  end

  s.subspec 'Pro' do |ss|
    ss.dependency 'UniAds/Base'
    ss.dependency 'UniAds/MdotM'
  end

  s.subspec 'All' do |ss|
    ss.dependency 'UniAds/Pro'
    ss.dependency 'UniAds/SmartMad'
    ss.dependency 'UniAds/AppLovin'
    ss.dependency 'UniAds/FlurryAds'
    ss.dependency 'UniAds/VunglePub'
    ss.dependency 'UniAds/AmazonAd'
  end

#
# Custom Adapters
#
  s.subspec 'SmartMadAdapter' do |ss|
    ss.source_files = 'UniAds/Adapters/SmartMad/*.*'
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

#
# Ads Networks specifications
#
  s.subspec 'iAd' do |ss|
    ss.dependency 'MoPubClient/iAdAdapter'
    ss.frameworks = 'iAd'
  end

  s.subspec 'AdMob' do |ss|
    ss.source_files = 'UniAds/AdMob/*.h'
    ss.frameworks = 'AudioToolbox', 'MessageUI', 'SystemConfiguration', 'CoreGraphics', 'AdSupport', 'StoreKit'
    ss.dependency 'MoPubClient/AdMobAdapter'
  end

  s.subspec 'MMSDK' do |ss|
    ss.source_files = 'UniAds/MMSDK/*.h'
    ss.frameworks = 'QuartzCore','MediaPlayer','CoreGraphics','CoreLocation','MobileCoreServices','AudioToolbox','AVFoundation','SystemConfiguration','UIKit','Foundation'
    ss.dependency 'MoPubClient/MillenialAdapter'
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
    ss.source_files = 'UniAds/Smaato/Extracted/Headers/*.h'
    ss.resources    = 'UniAds/Smaato/Extracted/Resources/**/*.{strings}'
    ss.dependency 'UniAds/SmaatoAdapter'
  end

  s.subspec 'AppLovin' do |ss|
    ss.source_files = 'UniAds/AppLovin/headers/*.h'
    ss.preserve_paths = '**/*.a'
    ss.library = 'AppLovinSdk'
    ss.frameworks = 'AdSupport','CoreTelephony','SystemConfiguration','StoreKit'
    ss.xcconfig  =  { 'LIBRARY_SEARCH_PATHS' => '"$(SRCROOT)/Pods/UniAds/UniAds/AppLovin"' }
    ss.dependency 'UniAds/AppLovinAdapter'
  end

  s.subspec 'FlurryAds' do |ss|
    ss.source_files = 'UniAds/FlurryAds/*.h'
    ss.preserve_paths = '**/*.a'
    ss.library = 'FlurryAds'
    ss.xcconfig  =  { 'LIBRARY_SEARCH_PATHS' => '"$(SRCROOT)/Pods/UniAds/UniAds/FlurryAds"' }
    ss.dependency 'UniAds/FlurryAdsAdapter'
  end

  s.subspec 'VunglePub' do |ss|
    ss.source_files = 'UniAds/VunglePub/**/*.h'
    ss.resources    = 'UniAds/VunglePub/resources/**/*.{png,bundle}'
    ss.preserve_paths = '**/*.a','UniAds/VunglePub'
    ss.library = 'vunglepub','z'
    ss.frameworks = 'AVFoundation','CFNetwork','CoreGraphics','AudioToolbox','CoreMedia','Foundation','MediaPlayer','QuartzCore','SystemConfiguration','UIKit','AdSupport','StoreKit','CoreLocation'
    ss.xcconfig  =  { 'LIBRARY_SEARCH_PATHS' => '"$(SRCROOT)/Pods/UniAds/UniAds/VunglePub/bin"',
                      'HEADER_SEARCH_PATHS' => '"$(SRCROOT)/Pods/UniAds/UniAds/VunglePub"' }
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

    ss.dependency 'UniAds/AdMob'
    ss.dependency 'UniAds/MMSDK'
    ss.dependency 'UniAds/Smaato'

    ss.dependency 'JSONKit'
  end

  s.dependency 'MoPubClient'

end
