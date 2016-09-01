#!/bin/sh -e

echo "git \"file://$(cd `pwd`/../.. && pwd)\" \"`git rev-parse HEAD`\"" > Cartfile

echo "Carthage `carthage version`"
carthage update --platform 'watchos' --verbose

xcodebuild -scheme 'watchOSApp' | xcpretty && exit ${PIPESTATUS[0]}

