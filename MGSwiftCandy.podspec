#
# Be sure to run `pod lib lint MGSwiftCandy.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MGSwiftCandy'
  s.version          = '1.0.1'
  s.summary          = 'A swift candy library.'
  s.swift_versions   = '4.2'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  A swift candy library, Provides a large number of easy-to-use features.
                       DESC

  s.homepage         = 'https://github.com/mszdream/MGSwiftCandy'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'mszdream' => 'mszdream@126.com' }
  s.source           = { :git => 'https://github.com/mszdream/MGSwiftCandy.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  
  s.subspec 'Core' do |ss|
    ss.source_files = 'MGSwiftCandy/Classes/Core/**/*'
  end
  
  s.subspec 'Extension' do |ss|
    ss.source_files = 'MGSwiftCandy/Classes/Extension/**/*'
    ss.dependency 'MGSwiftCandy/Core'
  end
  
  s.subspec 'Tools' do |ss|
    ss.source_files = 'MGSwiftCandy/Classes/Tools/**/*'
    ss.dependency 'MGSwiftCandy/Extension'
  end
  
  # s.source_files = 'MGSwiftCandy/Classes/**/*'
  
  # s.resource_bundles = {
  #   'MGSwiftCandy' => ['MGSwiftCandy/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
