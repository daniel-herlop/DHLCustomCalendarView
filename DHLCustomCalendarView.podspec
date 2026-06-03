Pod::Spec.new do |s|

s.platform = :ios
s.ios.deployment_target = '14.0'
s.name = "DHLCustomCalendarView"
s.summary = "Selector de un item/items de un listado"
s.requires_arc = true

s.version = "0.1.0"

s.license = { :type => "MIT", :file => "LICENSE" }

s.author = { "Daniel Hernandez Lopez" => "hzlzdaniel@gmail.com" }

s.homepage = "https://github.com/daniel-herlop/DHLCustomCalendarView"

s.source = { :git => "https://github.com/daniel-herlop/DHLCustomCalendarView.git", 
             :tag => "#{s.version}" }

s.framework = "UIKit"

s.source_files = "DHLCustomCalendarView/**/*.{swift}"

s.resources = "DHLCustomCalendarView/**/*.{png,jpeg,jpg,storyboard,xib,xcassets,strings}"

s.swift_version = "5.0"

end
