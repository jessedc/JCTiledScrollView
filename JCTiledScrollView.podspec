Pod::Spec.new do |s|
  s.name         = "JCTiledScrollView"
  s.version      = "0.0.2"
  s.summary      = "A set of classes that wrap UIScrollView and CATiledLayer. It aims to simplify displaying large images and PDFs at multiple zoom scales."
  s.homepage     = "https://github.com/jessedc/" + s.name
  s.license      = { :type => 'MIT', :file => 'LICENCE.txt' }
  s.author       = { "Jesse Collis" => "jesse@jcmultimedia.com.au" }
  s.source       = {
    :git => "https://github.com/jessedc/JCTiledScrollView.git",
    :tag => s.version.to_s
  }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = ['Headers/*.h', 'JCTiledScrollView/Source/*.m']

  s.framework  = 'Foundation', 'UIKit'

end
