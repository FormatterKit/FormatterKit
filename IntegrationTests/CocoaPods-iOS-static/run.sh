#!/bin/sh -e

bundle exec pod install
xcodebuild -workspace Example.xcworkspace -scheme Example -destination 'platform=iOS Simulator,name=iPhone 6' test | xcpretty && exit ${PIPESTATUS[0]}

