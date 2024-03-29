Pod::Spec.new do |s|
  s.name         = "Teleport"
  s.version      = "0.0.19"
  s.summary      = "Teleport is a lightweight model layer for Objective-C"
  s.homepage     = "http://github.com/BendingSpoons/Teleport"
  s.license      = { :type => 'MIT', :file => 'LICENSE.md' }
  s.author       = { "Luca Querella" => "lq@bendingspoons.dk"}
  s.source       = { :git => "https://github.com/BendingSpoons/Teleport.git", :tag => s.version.to_s }
  s.platform     = :ios, '6.0'
  s.source_files = 'Teleport/*.{h,m}'
  s.frameworks = 'UIKit', 'Foundation', 'QuartzCore', 'CoreGraphics'
  s.requires_arc = true
  s.dependency 'BlocksKit'
end
