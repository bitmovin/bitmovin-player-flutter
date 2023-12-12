#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint player.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name = 'bitmovin_player'
  s.version = '0.4.0'
  s.summary = 'Bitmovin Player Flutter plugin'
  s.description = <<-DESC
Flutter plugin for Bitmovin Player.
                  DESC
  s.homepage = 'https://bitmovin.com'
  s.license = { :file => '../LICENSE' }
  s.author = { 'Bitmovin' => 'support@bitmovin.com' }
  s.source = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'BitmovinPlayer', '3.49.0'
  s.platform = :ios, '14.0'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
