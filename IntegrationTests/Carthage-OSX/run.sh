#!/bin/sh -e

echo "git \"file://$(cd `pwd`/../.. && pwd)\" \"`git rev-parse HEAD`\"" > Cartfile
carthage update --platform 'OSX'
xcodebuild -scheme Example test | xcpretty && exit ${PIPESTATUS[0]}

