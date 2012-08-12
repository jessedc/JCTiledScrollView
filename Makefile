XCWORKSPACE=JCTiledScrollView.xcworkspace
XCCONFIG =ONLY_ACTIVE_ARCH=NO
XCODEBUILD_OPTS=$(XCCONFIG) -workspace $(XCWORKSPACE)
XCODEBUILD=xcodebuild $(XCODEBUILD_OPTS)
CONFIGURATION ?= Debug
SDK ?= iphonesimulator

.PHONY: jc-tiled-scrollview

default: jc-tiled-scrollview

jc-tiled-scrollview:
	$(XCODEBUILD) build -scheme JCTiledScrollView -configuration $(CONFIGURATION) -sdk $(SDK)
