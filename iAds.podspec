Pod::Spec.new do |s|
  s.name = 'iAds'
  s.version = '0.0.1'
  s.platform = :ios
  s.license = {:type => 'commercial',:text =>'text goes here'}
  s.summary = 'An unofficial clone of some ad SDK for iOS.'
  s.author = {'PI' => 'support@pi.com'}
  s.source = {:git => 'ssh://git@git.postindustria.com/adnets.git'}
  s.homepage = 'https://developers.google.com/mobile-ads-sdk/download#downloadios'
#  s.source_files  = 'iAds/**/*.{h,m,c,mm}'
  s.preserve_paths = 'iAds/Adapters'

#
# Third_Party_Source_Code
#
  s.subspec 'ZipArchive' do |ss|
    ss.source_files = 'iAds/SmartMad/Third_Party_Source_Code/ZipArchive/**/*.{h,m,c,mm}'
  end

  s.subspec 'Reachability' do |ss|
    ss.source_files = 'iAds/SmartMad/Third_Party_Source_Code/Reachability/**/*.{h,m,c,mm}'
  end

  s.subspec 'Cocoa_HTTP_Server' do |ss|
    ss.source_files = 'iAds/SmartMad/Third_Party_Source_Code/Cocoa HTTP Server/**/*.{h,m,c,mm}'
  end

  s.subspec 'Erica_Sadun' do |ss|
    ss.source_files = 'iAds/SmartMad/Third_Party_Source_Code/Erica Sadun/**/*.{h,m,c,mm}'
  end

#
# Custom Adapters
#
  s.subspec 'SmartMadAdapter' do |ss|
    ss.source_files = 'iAds/Adapters/MPSmartMadEventAdapter.*'
  end

  s.subspec 'SmaatoAdapter' do |ss|
    ss.source_files = 'iAds/Adapters/MPSmaatoEventAdapter.*'
  end

  s.subspec 'MdotMAdapter' do |ss|
    ss.source_files = 'iAds/Adapters/MPMdotMEventAdapter.*'
  end

#
# Ads Networks specifications
#
  s.subspec 'iAd' do |ss|
    ss.dependency 'mopub-client/iAdAdapter', :podspec => 'mopub-client.podspec'
  end

  s.subspec 'AdMob' do |ss|
    ss.source_files = FileList['iAds/AdMob/*.h']
    ss.preserve_paths = 'iAds/AdMob/Add-ons/{Mediation, Search, DoubleClick}', '**/*.a'
    ss.library = 'GoogleAdMobAds'
    ss.frameworks = 'AudioToolbox', 'MessageUI', 'SystemConfiguration', 'CoreGraphics', 'AdSupport', 'StoreKit'
    ss.xcconfig  =  { 'LIBRARY_SEARCH_PATHS' => '"$(SRCROOT)/Pods/iAds/iAds/AdMob"' }
    ss.dependency 'mopub-client/AdMobAdapter', :podspec => 'mopub-client.podspec'
  end

  s.subspec 'MMSDK' do |ss|
    ss.source_files = FileList['iAds/MMSDK/*.h']
    ss.preserve_paths = '**/*.a'
    ss.library = 'MMSDK'
    ss.frameworks = 'QuartzCore','MediaPlayer','CoreGraphics','CoreLocation','MobileCoreServices','AudioToolbox','AVFoundation','SystemConfiguration','UIKit','Foundation'
    ss.xcconfig  =  { 'LIBRARY_SEARCH_PATHS' => '"$(SRCROOT)/Pods/iAds/iAds/MMSDK"' }
    ss.dependency 'mopub-client/MillenialAdapter', :podspec => 'mopub-client.podspec'
  end

  s.subspec 'SmartMad' do |ss|
    ss.source_files = FileList['iAds/SmartMad/*.h']
    ss.resources    = 'iAds/SmartMad/*.{png,bundle}'
    ss.preserve_paths = '**/*.a'
    ss.library = 'SmartMad'
    ss.frameworks = 'AudioToolbox','AVFoundation','CoreLocation','CoreMotion','CoreTelephony','QuartzCore','MediaPlayer','StoreKit','SystemConfiguration','CFNetwork','MessageUI','EventKit'
    ss.xcconfig  =  { 'LIBRARY_SEARCH_PATHS' => '"$(SRCROOT)/Pods/iAds/iAds/SmartMad"' }
    ss.dependency 'iAds/ZipArchive'
    ss.dependency 'iAds/Erica_Sadun'
#    ss.dependency 'iAds/Reachability'
    ss.dependency 'iAds/Cocoa_HTTP_Server'
    ss.dependency 'iAds/SmartMadAdapter'
  end

  s.subspec 'MdotM' do |ss|
    ss.source_files = FileList['iAds/MdotM/*.h']
    ss.preserve_paths = '**/*.a'
    ss.library = 'MdotMSDK2','z','xml2'
    ss.frameworks = 'SystemConfiguration','MobileCoreServices','CFNetwork','UIKit','Foundation','CoreGraphics','MediaPlayer','QuartzCore','AdSupport'
    ss.xcconfig  =  { 'LIBRARY_SEARCH_PATHS' => '"$(SRCROOT)/Pods/iAds/iAds/MdotM"' }
    ss.dependency 'iAds/MdotMAdapter'
#    ss.dependency 'ASIHTTPRequest'
  end

  s.subspec 'Smaato' do |ss|
    ss.source_files = 'iAds/Smaato/iSoma.framework/Headers/*.h'
    ss.resources    = 'iAds/Smaato/iSoma.framework/Resources/**/*.{strings}'
    ss.preserve_paths = 'iAds/Smaato/iSoma.framework'
    ss.frameworks = 'iSoma','AdSupport','CoreGraphics','CoreLocation','Foundation','MediaPlayer','QuartzCore','StoreKit','SystemConfiguration','UIKit'
    ss.xcconfig  =  { 'FRAMEWORK_SEARCH_PATHS' => '"$(PODS_ROOT)/iAds/iAds/Smaato"' }
    ss.dependency 'iAds/SmaatoAdapter'
  end

end