#!/bin/sh -e

echo "git \"file://$(cd `pwd`/../.. && pwd)\" \"`git rev-parse HEAD`\"" > Cartfile

echo "Carthage `carthage version`"
carthage update --platform 'ios' --verbose

xcodebuild -scheme Example -destination 'platform=iOS Simulator,name=iPhone 7' test | xcpretty && exit ${PIPESTATUS[0]}

