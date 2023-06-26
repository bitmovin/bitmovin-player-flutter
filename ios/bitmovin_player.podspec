#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint player.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'bitmovin_player'
  s.version          = '0.0.1'
  s.summary          = 'Bitmovin Player Flutter plugin'
  s.description      = <<-DESC
Flutter plugin for Bitmovin Player.
                       DESC
  s.homepage         = 'https://bitmovin.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Bitmovin Inc.' => 'hardknockrabbit@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'

  s.dependency 'BitmovinPlayer'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
