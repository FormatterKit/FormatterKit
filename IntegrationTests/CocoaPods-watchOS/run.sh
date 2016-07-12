#!/bin/sh -e

bundle exec pod install
xcodebuild -workspace Example.xcworkspace -scheme Example build | xcpretty && exit ${PIPESTATUS[0]}

