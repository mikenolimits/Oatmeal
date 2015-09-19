#
# Be sure to run `pod lib lint Oatmeal.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = "OatmealFramework"
s.version          = "0.1.0"
s.summary          = "Oatmeal is a refreshing Swift Framework to make bootstrapping your apps much easier."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
s.description      = "Oatmeal is a refreshing Swift Framework to make bootstrapping your apps much easier. Mmmkay?"

s.homepage         = "https://github.com/mikenolimits/OatmealFramework"
# s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
s.license          = 'MIT'
s.author           = { "mikenolimits" => "empathynyc@gmail.com" }
s.source           = { :git => "https://github.com/mikenolimits/Oatmeal.git", :tag => s.version.to_s }
s.social_media_url = 'https://twitter.com/mikenolimits'

#s.platform     = :ios, '8.1'
s.requires_arc = true

s.source_files = 'Pod/Classes/**/*'
s.resource_bundles = {
'Oatmeal' => ['Pod/Assets/*.png']
}

# s.public_header_files = 'Pod/Classes/**/*.h'
# s.frameworks = 'UIKit', 'MapKit'

s.ios.deployment_target = '8.0'
s.osx.deployment_target = '10.9'

#s.watchos.deployment_target = '2.0'

s.dependency 'SwiftyJSON'
s.dependency 'Alamofire','~> 2.0'
s.dependency 'AlamofireImage', '~> 1.0.0'
end