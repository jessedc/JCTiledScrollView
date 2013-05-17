Pod::Spec.new do |spec|
  spec.name = "JCTiledScrollView"
  spec.version = '0.0.1'
  spec.source = {:git => 'git@github.com:jessedc/JCTiledScrollView.git'}
  spec.source_files = ['Headers/*.h', 'JCTiledScrollView/Source/*.m']
  spec.requires_arc = true
end
