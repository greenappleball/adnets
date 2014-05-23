Pod::Spec.new do |s|
  s.name = 'UniAds'
  s.version = '3.5.0'
  s.platform = :ios, '6.0'
  s.license = {:type => 'commercial',:text =>'text goes here'}
  s.summary = 'An unofficial clone of some ad SDK for iOS.'
  s.author = {'PI' => 'support@pi.com'}
  s.source = {:git => 'https://github.com/greenappleball/adnets.git', :tag => '3.5.0'}
  s.homepage = 'http://lifelikeapps.com'
  s.default_subspec = 'Base'
  s.requires_arc = false

  s.subspec 'AdapterData' do |ss|
    ss.source_files  = 'UniAds/Adapters/*.{h,m,c,mm}'
    ss.requires_arc = true
  end
#
# Preferred subspec: fix adding the pod to git repos
#
  s.subspec 'Base' do |ss|
    ss.dependency 'UniAds/Millennial'
    ss.dependency 'UniAds/Smaato'
    ss.dependency 'UniAds/AdMob'
    ss.dependency 'UniAds/OLAd'
    ss.dependency 'UniAds/iAd'
  end

  s.subspec 'All' do |ss|
    ss.dependency 'UniAds/Base'
    ss.dependency 'UniAds/InMobi'
    ss.dependency 'UniAds/SmartMad'
    ss.dependency 'UniAds/AppLovin'
    ss.dependency 'UniAds/AmazonAd'
    ss.dependency 'UniAds/FlurryAds'
    ss.dependency 'UniAds/VunglePub'
    ss.dependency 'UniAds/AppSponsor'
  end

#
# iAd
#
  s.subspec 'iAd' do |ss|
    ss.dependency 'mopub-ios-sdk/iAd'
  end

#
# Smaato
#
  s.subspec 'SmaatoSDK' do |ss|
    ss.source_files = 'UniAds/SDKs/Smaato/Headers/*.h'
    ss.resources    = 'UniAds/SDKs/Smaato/Resources/**/*.{strings}'
    ss.dependency 'UniAds/OLAdSDK'
  end

  s.subspec 'Smaato' do |ss|
    ss.source_files = 'UniAds/Adapters/Smaato/*.*'
    ss.dependency 'UniAds/AdapterData'
    ss.dependency 'UniAds/SmaatoSDK'
    ss.requires_arc = true
  end

#
# AdMob
#
  s.subspec 'AdMob' do |ss|
    ss.dependency 'mopub-ios-sdk/AdMob'
    ss.xcconfig  =  { 'LIBRARY_SEARCH_PATHS' => '' }
  end

#
# Millennial
#
   s.subspec 'MillennialSDK' do |ss|
    ss.source_files = 'UniAds/SDKs/MMSDK/MillennialMedia.framework/Headers/*.h'
    ss.header_dir = 'MillennialMedia'
#    ss.dependency 'MillennialMediaSDK'
    ss.dependency 'UniAds/OLAdSDK'
  end

 s.subspec 'Millennial' do |ss|
    ss.source_files = 'UniAds/Adapters/Millennial/*.*'
    ss.dependency 'UniAds/MillennialSDK'
    ss.requires_arc = false
  end

#
# OLAd
#
  s.subspec 'OLAdSDK' do |ss|
    ss.source_files = 'UniAds/SDKs/OLAdKitSDK/*.{h,m}'
    ss.resources    = 'UniAds/SDKs/OLAdKitSDK/*.{png,bundle}'
    ss.preserve_paths = 'UniAds/SDKs/OLAdKitSDK/*.{a,txt}'
    ss.library = 'OLAdKitSDK'
    ss.frameworks = 'PassKit','StoreKit','AdSupport','AudioToolbox','AVFoundation','CoreLocation','CoreGraphics','EventKit','EventKitUI','MediaPlayer','MobileCoreServices','QuartzCore','SystemConfiguration','Social','Accounts','CoreTelephony','MessageUI','iAd','AssetsLibrary'
    ss.xcconfig  =  { 'LIBRARY_SEARCH_PATHS' => '"$(PODS_ROOT)/UniAds/UniAds/SDKs/OLAdKitSDK"' }
  end

  s.subspec 'OLAd' do |ss|
    ss.source_files = 'UniAds/Adapters/OLAd/*.*'
    ss.dependency 'UniAds/AdapterData'
    ss.dependency 'UniAds/OLAdSDK'
    ss.requires_arc = true
  end

#
# SmartMad
#
  s.subspec 'SmartMadSDK' do |ss|
    ss.source_files = 'UniAds/SDKs/SmartMad/*.h'
    ss.resources    = 'UniAds/SDKs/SmartMad/*.{png,bundle}'
    ss.preserve_paths = 'UniAds/SDKs/SmartMad/*.a'
    ss.library = 'SmartMad','z'
    ss.frameworks = 'AudioToolbox','AdSupport','CoreLocation','CoreMotion','CoreTelephony','AVFoundation','QuartzCore','MediaPlayer','StoreKit','SystemConfiguration','CFNetwork','MessageUI','EventKit','EventKitUI'
    ss.xcconfig  =  { 'LIBRARY_SEARCH_PATHS' => '"$(PODS_ROOT)/UniAds/UniAds/SDKs/SmartMad"' }
  end

  s.subspec 'SmartMad' do |ss|
    ss.source_files = 'UniAds/Adapters/SmartMad/*.*'
    ss.dependency 'UniAds/AdapterData'
    ss.dependency 'UniAds/SmartMadSDK'
    ss.requires_arc = true
  end

#
# MdotM
#
  s.subspec 'MdotMSDK' do |ss|
    ss.source_files = 'UniAds/SDKs/MdotM/*.h'
    ss.preserve_paths = 'UniAds/SDKs/MdotM/*.a'
    ss.library = 'MdotMSDK2','z','xml2'
    ss.frameworks = 'SystemConfiguration','MobileCoreServices','CFNetwork','UIKit','Foundation','CoreGraphics','MediaPlayer','QuartzCore','AdSupport'
    ss.xcconfig  =  { 'LIBRARY_SEARCH_PATHS' => '"$(PODS_ROOT)/UniAds/UniAds/SDKs/MdotM"' }
  end

  s.subspec 'MdotM' do |ss|
    ss.source_files = 'UniAds/Adapters/MdotM/*.*'
    ss.dependency 'UniAds/AdapterData'
    ss.dependency 'UniAds/MdotMSDK'
    ss.requires_arc = true
  end

#
# AppLovin
#
  s.subspec 'AppLovinSDK' do |ss|
    ss.source_files = 'UniAds/SDKs/AppLovin/headers/*.h'
    ss.preserve_paths = 'UniAds/SDKs/AppLovin/*.a'
    ss.library = 'AppLovinSdk'
    ss.frameworks = 'AdSupport','CoreTelephony','CoreGraphics','MediaPlayer','SystemConfiguration','StoreKit'
    ss.xcconfig  =  { 'LIBRARY_SEARCH_PATHS' => '"$(PODS_ROOT)/UniAds/UniAds/SDKs/AppLovin"' }
  end

  s.subspec 'AppLovin' do |ss|
    ss.source_files = 'UniAds/Adapters/AppLovin/*.*'
    ss.dependency 'UniAds/AdapterData'
    ss.dependency 'UniAds/AppLovinSDK'
    ss.requires_arc = true
  end

#
# Flurry
#
  s.subspec 'FlurryAds' do |ss|
    ss.source_files = 'UniAds/Adapters/FlurryAds/*.*'
    ss.dependency 'UniAds/AdapterData'
    ss.dependency 'FlurrySDK/FlurryAds'
    ss.requires_arc = true
  end

#
# Vungle
#
  s.subspec 'VunglePubSDK' do |ss|
    ss.resources    = 'UniAds/SDKs/VunglePub/Resources/*.*'
    ss.preserve_paths = 'UniAds/SDKs/VunglePub/vunglepub.framework'
    ss.library = 'z'
    ss.frameworks = 'vunglepub','AVFoundation','CFNetwork','CoreGraphics','AudioToolbox','CoreMedia','Foundation','MediaPlayer','QuartzCore','SystemConfiguration','UIKit','AdSupport','StoreKit','CoreLocation'
    ss.xcconfig  =  { 'FRAMEWORK_SEARCH_PATHS' => '"$(PODS_ROOT)/UniAds/UniAds/SDKs/VunglePub"' }
  end

  s.subspec 'VunglePub' do |ss|
    ss.source_files = 'UniAds/Adapters/VunglePub/*.*'
    ss.dependency 'UniAds/AdapterData'
    ss.dependency 'UniAds/VunglePubSDK'
    ss.requires_arc = true
  end

#
# Amazon
#
  s.subspec 'AmazonAdSDK' do |ss|
    ss.preserve_paths = 'UniAds/SDKs/AmazonAd/AmazonAd.framework'
    ss.frameworks = 'AmazonAd','AdSupport','CoreGraphics','CoreLocation','Foundation','MediaPlayer','QuartzCore','StoreKit','SystemConfiguration','UIKit'
    ss.xcconfig  =  { 'FRAMEWORK_SEARCH_PATHS' => '"$(PODS_ROOT)/UniAds/UniAds/SDKs/AmazonAd"' }
  end

  s.subspec 'AmazonAd' do |ss|
    ss.source_files = 'UniAds/Adapters/Amazon/*.*'
    ss.dependency 'UniAds/AdapterData'
    ss.dependency 'UniAds/AmazonAdSDK'
    ss.requires_arc = true
  end

#
# InMobi
#
  s.subspec 'InMobi' do |ss|
    ss.source_files = 'UniAds/Adapters/InMobi/*.*'
    ss.dependency 'UniAds/AdapterData'
    ss.dependency 'InMobiSDK'
    ss.requires_arc = true
  end

#
# AppSponsor
#
  s.subspec 'AppSponsorSDK' do |ss|
    ss.resources    = 'UniAds/SDKs/AppSponsor/Resources/*.*'
    ss.preserve_paths = 'UniAds/SDKs/AppSponsor/AppSponsorSDK.framework'
    ss.library = 'z','stdc++'
    ss.frameworks = 'AppSponsorSDK','AudioToolbox','QuartzCore','OpenGLES','Security','CFNetwork','SystemConfiguration','CoreMotion','CoreGraphics','UIKit','Foundation'
    ss.weak_frameworks = 'AdSupport','CoreLocation','StoreKit','Accelerate'
    ss.xcconfig  =  { 'FRAMEWORK_SEARCH_PATHS' => '"$(PODS_ROOT)/UniAds/UniAds/SDKs/AppSponsor"' }
  end

  s.subspec 'AppSponsor' do |ss|
    ss.source_files = 'UniAds/Adapters/AppSponsor/*.*'
    ss.dependency 'UniAds/AdapterData'
    ss.dependency 'UniAds/AppSponsorSDK'
    ss.requires_arc = true
  end

  s.prepare_command = '/usr/bin/unzip ./UniAds/SDKs/OLAdKitSDK.zip -d ./UniAds/SDKs/'
  s.dependency 'mopub-ios-sdk', '~>2.1.0'

end
