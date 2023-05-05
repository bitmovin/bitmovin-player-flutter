# Installation

Run the following command to install **bitmovin_sdk**

`flutter pub add bitmovin_sdk`

Then add your license key (see [guide]("../documents/license.md))

</br>

## For Android
No extra steps needed.

</br>

## For iOS
Add this source on top of your `Podfile`
```terminal
source https://github.com/bitmovin/cocoapod-specs.git
```

</br>

eg:
```script

# Uncomment this line to define a global platform for your project
platform :ios, '14.0'
source 'https://github.com/bitmovin/cocoapod-specs.git'

... The rest of your PodFile ...

target 'Runner' do
  # use_frameworks!
  use_modular_headers!

  pod 'BitmovinPlayer', '3.37.1'
  
  flutter_install_all_ios_pods File.dirname(File.realpath(__FILE__))
end
```