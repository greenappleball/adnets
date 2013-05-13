Pod::Spec.new do |s|
  s.name = 'UniAds'
  s.version = '0.0.1'
  s.platform = :ios
  s.license = {:type => 'commercial',:text =>'text goes here'}
  s.summary = 'An unofficial clone of some ad SDK for iOS.'
  s.author = {'PI' => 'support@pi.com'}
  s.source = {:git => 'ssh://git@git.postindustria.com/adnets.git'}
  s.homepage = 'https://developers.google.com/mobile-ads-sdk/download#downloadios'
#  s.source_files  = 'UniAds/**/*.{h,m,c,mm}'
  s.preserve_paths = 'UniAds/Adapters'

  s.preferred_dependency = '_UniAds_'
#
# Empty subspec: fix adding the pod to git repos
#
  s.subspec '_UniAds_' do |ss|
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
    ss.source_files = 'UniAds/Adapters/MPSmartMadEventAdapter.*'
  end

  s.subspec 'SmaatoAdapter' do |ss|
    ss.source_files = 'UniAds/Adapters/MPSmaatoEventAdapter.*'
  end

  s.subspec 'MdotMAdapter' do |ss|
    ss.source_files = 'UniAds/Adapters/MPMdotMEventAdapter.*'
  end

#
# Ads Networks specifications
#
  s.subspec 'iAd' do |ss|
#ss.dependency 'mopub-client/iAdAdapter', :podspec => 'mopub-client.podspec'
    ss.frameworks = 'iAd'
  end

  s.subspec 'AdMob' do |ss|
    ss.source_files = FileList['UniAds/AdMob/*.h']
    ss.preserve_paths = 'UniAds/AdMob/Add-ons/{Mediation, Search, DoubleClick}', '**/*.a'
    ss.library = 'GoogleAdMobAds'
    ss.frameworks = 'AudioToolbox', 'MessageUI', 'SystemConfiguration', 'CoreGraphics', 'AdSupport', 'StoreKit'
    ss.xcconfig  =  { 'LIBRARY_SEARCH_PATHS' => '"$(SRCROOT)/Pods/UniAds/UniAds/AdMob"' }
    ss.dependency 'mopub-client/AdMobAdapter', :podspec => 'mopub-client.podspec'
  end

  s.subspec 'MMSDK' do |ss|
    ss.source_files = FileList['UniAds/MMSDK/*.h']
    ss.preserve_paths = '**/*.a'
    ss.library = 'MMSDK'
    ss.frameworks = 'QuartzCore','MediaPlayer','CoreGraphics','CoreLocation','MobileCoreServices','AudioToolbox','AVFoundation','SystemConfiguration','UIKit','Foundation'
    ss.xcconfig  =  { 'LIBRARY_SEARCH_PATHS' => '"$(SRCROOT)/Pods/UniAds/UniAds/MMSDK"' }
#   ss.dependency 'mopub-client/MillenialAdapter', :podspec => 'mopub-client.podspec'
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

end
