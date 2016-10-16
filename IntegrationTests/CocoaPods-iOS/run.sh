#!/bin/sh -e

bundle exec pod install
xcodebuild -workspace Example.xcworkspace -scheme Example -destination 'platform=iOS Simulator,name=iPhone 7' test | xcpretty && exit ${PIPESTATUS[0]}

