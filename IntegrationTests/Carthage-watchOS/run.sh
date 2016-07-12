#!/bin/sh -e

echo "git \"file://$(cd `pwd`/../.. && pwd)\" \"`git rev-parse HEAD`\"" > Cartfile
carthage update --platform 'watchos'
xcodebuild -scheme 'watchOSApp' | xcpretty && exit ${PIPESTATUS[0]}

