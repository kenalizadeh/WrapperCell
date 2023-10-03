#
# Be sure to run `pod lib lint WrapperCell.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name                    = 'WrapperCell'
  s.version                 = '0.0.1'
  s.summary                 = 'A short description of WrapperCell.'
  s.swift_version           = '5.0'
  s.ios.deployment_target   = '9.0'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Turn your UIViews into table view cells easily.
                       DESC

  s.homepage         = 'https://github.com/kenalizadeh/WrapperCell'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Kenan Alizadeh' => 'kananalizade@gmail.com' }
  s.source           = { :git => 'git@github.com:kenalizadeh/WrapperCell.git', :tag => s.version.to_s }

  s.source_files = 'WrapperCell/Classes/**/*'
end
