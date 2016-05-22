#!/bin/sh -e

bundle exec pod install
xcodebuild -workspace Example.xcworkspace -scheme Example -sdk iphonesimulator test | xcpretty && exit ${PIPESTATUS[0]}

