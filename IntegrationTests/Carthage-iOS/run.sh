#!/bin/sh -e

echo "git \"file://$(cd `pwd`/../.. && pwd)\" \"`git rev-parse HEAD`\"" > Cartfile
carthage update --platform 'ios'
xcodebuild -scheme Example -sdk iphonesimulator test | xcpretty && exit ${PIPESTATUS[0]}

