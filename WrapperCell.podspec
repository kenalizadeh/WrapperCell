#
# Be sure to run `pod lib lint WrapperCell.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name                    = 'WrapperCell'
  s.version                 = '1.0.0'
  s.summary                 = 'Generic cell wrapper for UITableView.'
  s.swift_version           = '5.0'
  s.ios.deployment_target   = '10.0'

  s.description      = <<-DESC
Easily turn your `UIView`s into `UITableViewCell`s.
                       DESC

  s.homepage         = 'https://github.com/kenalizadeh/WrapperCell'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Kenan Alizadeh' => 'kananalizade@gmail.com' }
  s.source           = { :git => 'https://github.com/kenalizadeh/WrapperCell.git', :tag => s.version.to_s }

  s.source_files = 'WrapperCell/Classes/**/*'
end
