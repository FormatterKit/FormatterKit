#!/bin/sh -e

bundle exec pod install
xcodebuild -workspace Example.xcworkspace -scheme Example build CODE_SIGNING_ALLOWED=NO CODE_SIGNING_REQUIRED=NO | xcpretty && exit ${PIPESTATUS[0]}

