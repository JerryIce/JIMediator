#
# Be sure to run `pod lib lint JIMediator.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JIMediator'
  s.version          = '0.5.0'
  s.summary          = '中介者模式管理业务功能块和控制器'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
采用中介者模式：管理业务功能块（可扩展、增加）以及各个业务控制器的路由逻辑减少耦合，路由逻辑采用URLNavigator
                       DESC

  s.homepage         = 'https://github.com/JerryIce/JIMediator'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jerry' => 'jerryelectricity@me.com' }
  s.source           = { :git => 'https://github.com/JerryIce/JIMediator.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'JIMediator/Classes/**/*'
  s.swift_version = '5'
  
  # s.resource_bundles = {
  #   'JIMediator' => ['JIMediator/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'URLNavigator'
end
