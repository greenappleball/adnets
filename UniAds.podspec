Pod::Spec.new do |s|
  s.name = 'UniAds'
  s.version = '1.3.0'
  s.platform = :ios
  s.license = {:type => 'commercial',:text =>'text goes here'}
  s.summary = 'An unofficial clone of some ad SDK for iOS.'
  s.author = {'PI' => 'support@pi.com'}
  s.source = {:git => 'ssh://git@git.postindustria.com/adnets.git'}
  s.homepage = 'https://developers.google.com/mobile-ads-sdk/download#downloadios'
#  s.source_files  = 'UniAds/**/*.{h,m,c,mm}'
  s.preserve_paths = 'UniAds/Adapters'

  s.preferred_dependency = 'Base'
#
# Preferred subspec: fix adding the pod to git repos
#
  s.subspec 'Base' do |ss|
    ss.dependency 'UniAds/iAd'
    ss.dependency 'UniAds/AdMob'
    ss.dependency 'UniAds/MMSDK'
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
  end
  
#
# Third_Party_Source_Code
#
  s.subspec 'ZipArchive' do |ss|
    ss.source_files = 'UniAds/SmartMad/Third_Party_Source_Code/ZipArchive/**/*.{h,m,c,mm}'
  end

  s.subspec 'Reachability' do |ss|
    ss.source_files = 'UniAds/SmartMad/Third_Party_Source_Code/Reachability/**/*.{h,m,c,mm}'
  end

  s.subspec 'Cocoa_HTTP_Server' do |ss|
    ss.source_files = 'UniAds/SmartMad/Third_Party_Source_Code/Cocoa HTTP Server/**/*.{h,m,c,mm}'
  end

  s.subspec 'Erica_Sadun' do |ss|
    ss.source_files = 'UniAds/SmartMad/Third_Party_Source_Code/Erica Sadun/**/*.{h,m,c,mm}'
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

#
# Ads Networks specifications
#
  s.subspec 'iAd' do |ss|
    ss.dependency 'MoPubClient/iAdAdapter'
    ss.frameworks = 'iAd'
  end

  s.subspec 'AdMob' do |ss|
    ss.source_files = FileList['UniAds/AdMob/*.h']
    ss.preserve_paths = 'UniAds/AdMob/Add-ons/{Mediation, Search, DoubleClick}', '**/*.a'
    ss.library = 'GoogleAdMobAds'
    ss.frameworks = 'AudioToolbox', 'MessageUI', 'SystemConfiguration', 'CoreGraphics', 'AdSupport', 'StoreKit'
    ss.xcconfig  =  { 'LIBRARY_SEARCH_PATHS' => '"$(SRCROOT)/Pods/UniAds/UniAds/AdMob"' }
    ss.dependency 'MoPubClient/AdMobAdapter'
  end

  s.subspec 'MMSDK' do |ss|
    ss.source_files = FileList['UniAds/MMSDK/*.h']
    ss.preserve_paths = '**/*.a'
    ss.library = 'MMSDK'
    ss.frameworks = 'QuartzCore','MediaPlayer','CoreGraphics','CoreLocation','MobileCoreServices','AudioToolbox','AVFoundation','SystemConfiguration','UIKit','Foundation'
    ss.xcconfig  =  { 'LIBRARY_SEARCH_PATHS' => '"$(SRCROOT)/Pods/UniAds/UniAds/MMSDK"' }
    ss.dependency 'MoPubClient/MillenialAdapter'
  end

  s.subspec 'SmartMad' do |ss|
    ss.source_files = FileList['UniAds/SmartMad/*.h']
    ss.resources    = 'UniAds/SmartMad/*.{png,bundle}'
    ss.preserve_paths = '**/*.a'
    ss.library = 'SmartMad'
    ss.frameworks = 'AudioToolbox','AVFoundation','CoreLocation','CoreMotion','CoreTelephony','QuartzCore','MediaPlayer','StoreKit','SystemConfiguration','CFNetwork','MessageUI','EventKit'
    ss.xcconfig  =  { 'LIBRARY_SEARCH_PATHS' => '"$(SRCROOT)/Pods/UniAds/UniAds/SmartMad"' }
    ss.dependency 'UniAds/ZipArchive'
    ss.dependency 'UniAds/Erica_Sadun'
#    ss.dependency 'UniAds/Reachability'
    ss.dependency 'UniAds/Cocoa_HTTP_Server'
    ss.dependency 'UniAds/SmartMadAdapter'
  end

  s.subspec 'MdotM' do |ss|
    ss.source_files = FileList['UniAds/MdotM/*.h']
    ss.preserve_paths = '**/*.a'
    ss.library = 'MdotMSDK2','z','xml2'
    ss.frameworks = 'SystemConfiguration','MobileCoreServices','CFNetwork','UIKit','Foundation','CoreGraphics','MediaPlayer','QuartzCore','AdSupport'
    ss.xcconfig  =  { 'LIBRARY_SEARCH_PATHS' => '"$(SRCROOT)/Pods/UniAds/UniAds/MdotM"' }
    ss.dependency 'UniAds/MdotMAdapter'
#    ss.dependency 'ASIHTTPRequest'
  end

  s.subspec 'Smaato' do |ss|
    ss.source_files = 'UniAds/Smaato/iSoma.framework/Headers/*.h'
    ss.resources    = 'UniAds/Smaato/iSoma.framework/Resources/**/*.{strings}'
    ss.preserve_paths = 'UniAds/Smaato/iSoma.framework'
    ss.frameworks = 'iSoma','AdSupport','CoreGraphics','CoreLocation','Foundation','MediaPlayer','QuartzCore','StoreKit','SystemConfiguration','UIKit'
    ss.xcconfig  =  { 'FRAMEWORK_SEARCH_PATHS' => '"$(PODS_ROOT)/UniAds/UniAds/Smaato"' }
    ss.dependency 'UniAds/SmaatoAdapter'
  end

  s.subspec 'AppLovin' do |ss|
    ss.source_files = FileList['UniAds/AppLovin/headers/*.h']
    ss.preserve_paths = '**/*.a'
    ss.library = 'AppLovinSdk'
    ss.frameworks = 'AdSupport','CoreTelephony','SystemConfiguration','StoreKit'
    ss.xcconfig  =  { 'LIBRARY_SEARCH_PATHS' => '"$(SRCROOT)/Pods/UniAds/UniAds/AppLovin"' }
    ss.dependency 'UniAds/AppLovinAdapter'
  end

  s.subspec 'FlurryAds' do |ss|
    ss.source_files = FileList['UniAds/FlurryAds/*.h']
    ss.preserve_paths = '**/*.a'
    ss.library = 'FlurryAds'
    ss.xcconfig  =  { 'LIBRARY_SEARCH_PATHS' => '"$(SRCROOT)/Pods/UniAds/UniAds/FlurryAds"' }
    ss.dependency 'UniAds/FlurryAdsAdapter'
  end

  s.subspec 'VunglePub' do |ss|
    ss.source_files = FileList['UniAds/VunglePub/**/*.h']
    ss.resources    = 'UniAds/VunglePub/resources/**/*.{png,bundle}'
    ss.preserve_paths = '**/*.a','UniAds/VunglePub'
    ss.library = 'vunglepub'
    ss.xcconfig  =  { 'LIBRARY_SEARCH_PATHS' => '"$(SRCROOT)/Pods/UniAds/UniAds/VunglePub/bin"',
                      'HEADER_SEARCH_PATHS' => '"$(SRCROOT)/Pods/UniAds/UniAds/VunglePub"' }
    ss.dependency 'UniAds/VunglePubAdapter'
  end

  s.dependency 'MoPubClient', '~> 1.12.3.0'

end
