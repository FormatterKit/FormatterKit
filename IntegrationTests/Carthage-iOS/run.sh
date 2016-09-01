#!/bin/sh -e

echo "git \"file://$(cd `pwd`/../.. && pwd)\" \"`git rev-parse HEAD`\"" > Cartfile

echo "Carthage `carthage version`"
carthage update --platform 'ios' --verbose

xcodebuild -scheme Example -sdk iphonesimulator test | xcpretty && exit ${PIPESTATUS[0]}

