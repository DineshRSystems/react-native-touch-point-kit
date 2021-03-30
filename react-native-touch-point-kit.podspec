# react-native-touch-point-kit.podspec

require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "react-native-touch-point-kit"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.description  = <<-DESC
                  react-native-touch-point-kit
                   DESC
  s.homepage     = "https://github.com/DineshRSystems/react-native-touch-point-kit"
  # brief license entry:
  s.license      = "MIT"
  # optional - use expanded license entry instead:
  # s.license    = { :type => "MIT", :file => "LICENSE" }
  s.authors      = { "DineshRSystems" => "Dinesh.Kumar@rsystems.com" }
  s.platforms    = { :ios => "10.0" }
  s.source       = { :git => "https://github.com/DineshRSystems/react-native-touch-point-kit.git", :tag => "#{s.version}" }

  s.source_files = "ios/**/*.{h,c,cc,cpp,m,mm,swift}"
  s.requires_arc = true

  s.dependency "React"
  s.dependency 'TouchPointKit'
end

