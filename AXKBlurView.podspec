Pod::Spec.new do |s|
  s.name         = 'AXKBlurView'
  s.version      = '1.1.3'
  s.license      = 'MIT'
  s.summary      = 'UIView with realtime background blur effect.'
  s.author       = { 'Alexander Kolov' => 'me@alexkolov.com' }
  s.source       = { :git => 'https://github.com/silverity/AXKBlurView.git', :tag => '1.1.3' }
  s.homepage     = 'http://github.com/silverity/AXKBlurView'
  s.platform     = :ios
  s.source_files = 'Classes'
  s.frameworks   = 'Accelerate'
  s.requires_arc = true
  s.ios.deployment_target = '7.0'
end
