Pod::Spec.new do |s|
  s.name         = 'AKXBlurView'
  s.version      = '1.0.0'
  s.license      = 'MIT'
  s.summary      = 'UIView with realtime background blur effect.'
  s.author       = { 'Alexander Kolov' => 'me@alexkolov.com' }
  s.source       = { :git => 'https://github.com/silverity/AKXBlurView.git', :tag => '1.0.0' }
  s.homepage     = 'http://github.com/silverity/AKXBlurView'
  s.platform     = :ios
  s.source_files = 'Classes'
  s.frameworks   = 'Accelerate'
  s.requires_arc = true
  s.ios.deployment_target = '7.0'
end