#!/bin/sh -e

bundle exec pod install
xcodebuild -workspace Example.xcworkspace -scheme Example -destination 'platform=tvOS Simulator,name=Apple TV' test | xcpretty && exit ${PIPESTATUS[0]}

