#
# Be sure to run `pod lib lint Dplayer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Dplayer'
  s.version          = '1.3.0'
  s.summary          = 'A video player.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A video player developed by Swift.
                       DESC

  s.homepage         = 'https://github.com/weifengsmile/Dplayer'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'sidney' => '516202795@qq.com' }
  s.source           = { :git => 'https://github.com/weifengsmile/Dplayer.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'Dplayer/Classes/**/*'
  
  s.resource_bundles = {
     'Dplayer' => ['Dplayer/**/*.{xib,xcassets,gif,png,jpg,jpeg,metal,metallib,ci.metal,ci.metallib,air,ci.air}'],
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'SnapKit', '~> 5.0.0'
  s.dependency 'Toast-Swift', '~> 5.0.1'
  s.swift_version= "4.2"
end
