Pod::Spec.new do |s|
  s.name         = "JCTiledScrollView"
  s.version      = "0.0.1"
  s.summary      = "A set of classes that wrap UIScrollView and CATiledLayer. It aims to simplify displaying large images and PDFs at multiple zoom scales."
  s.homepage     = "https://github.com/jessedc/" + s.name
  s.license      = { :type => 'BSD', :file => 'LICENCE.txt' }
  s.author       = { "Jesse Collis" => "jesse@jcmultimedia.com.au" }
  s.source       = {
    :git => "https://github.com/yichizhang/JCTiledScrollView.git",
    :tag => s.version.to_s
  }

  s.platform     = :ios, '6.0'
  s.requires_arc = true

  s.source_files = ['Headers/*.h', 'JCTiledScrollView/Source/*.m']

  s.framework  = 'Foundation', 'UIKit'

end
