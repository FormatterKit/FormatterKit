#!/bin/sh -e

bundle exec pod install
xcodebuild -workspace Example.xcworkspace -scheme Example -sdk appletvsimulator test | xcpretty && exit ${PIPESTATUS[0]}

