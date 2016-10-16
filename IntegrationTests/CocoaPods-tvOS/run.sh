#!/bin/sh -e

bundle exec pod install
xcodebuild -workspace Example.xcworkspace -scheme Example -destination 'platform=tvOS Simulator,name=Apple TV 1080p' test | xcpretty && exit ${PIPESTATUS[0]}

