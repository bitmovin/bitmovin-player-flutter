require 'yaml'

package = YAML.load(File.read(File.join(__dir__, "../pubspec.yaml")))

Pod::Spec.new do |s|
  s.name = package['name']
  s.version = package['version']
  s.summary = package['description']
  s.homepage = package['homepage']
  s.license = { :file => '../LICENSE' }
  s.author = { 'Bitmovin' => 'support@bitmovin.com' }
  s.source = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'BitmovinPlayer', '3.94.0'
  s.platform = :ios, '14.0'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
