#!/bin/sh -e

echo "git \"file://$(cd `pwd`/../.. && pwd)\" \"`git rev-parse HEAD`\"" > Cartfile
carthage update --platform 'tvos'
xcodebuild -scheme Example -sdk appletvsimulator test | xcpretty && exit ${PIPESTATUS[0]}

