#!/bin/sh -e

echo "git \"file://$(cd `pwd`/../.. && pwd)\" \"`git rev-parse HEAD`\"" > Cartfile

echo "Carthage `carthage version`"
carthage update --platform 'tvos' --verbose

xcodebuild -scheme Example -sdk appletvsimulator test | xcpretty && exit ${PIPESTATUS[0]}

