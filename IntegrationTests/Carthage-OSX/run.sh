#!/bin/sh -e

echo "git \"file://$(cd `pwd`/../.. && pwd)\" \"`git rev-parse HEAD`\"" > Cartfile

echo "Carthage `carthage version`"
carthage update --platform 'OSX' --verbose

xcodebuild -scheme Example test | xcpretty && exit ${PIPESTATUS[0]}

