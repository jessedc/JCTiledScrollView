Pod::Spec.new do |s|
  s.name         = "JCTiledScrollView"
  s.version      = "0.0.1"
  s.summary      = "It helps make working with IonIcons easier."
  s.homepage     = "https://github.com/yichizhang/" + s.name
  s.license      = { :type => 'BSD', :file => 'LICENCE.txt' }
  s.author       = { "Yichi Zhang" => "zhang-yi-chi@hotmail.com" }
  s.source       = {
    :git => "https://github.com/yichizhang/JCTiledScrollView.git",
    :tag => s.version.to_s
  }

  s.platform     = :ios, '6.0'
  s.requires_arc = true

  s.source_files = ['Headers/*.h', 'JCTiledScrollView/Source/*.m']

  s.framework  = 'Foundation', 'UIKit'

end
