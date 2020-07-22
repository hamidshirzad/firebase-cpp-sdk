#!/bin/bash -ex

if [[ -z $(which cmake) ]]; then
    echo "Error, cmake is not installed or is not in the PATH."
    exit 1
fi
if [[ -z $(which xcodebuild) || -z $(which xcode-select) ]]; then
    echo "Error, Xcode command line tools not installed."
    exit 1
fi

if [[ -z $(xcode-select -p) || ! -d  $(xcode-select -p) ]]; then
    echo "Error, no Xcode version selected. Use 'xcode-select' to select one."
    exit 1
fi

if [[ -z $(which pod) ]]; then
    echo "Cocoapods not detected, installing..."
    sudo gem install cocoapods
fi

pod repo update

