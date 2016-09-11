#!/bin/bash

git submodule update --remote
rm -rf swift-proposal-analyzer.playground/Resources/proposals/
cp -r swift-evolution/proposals/ swift-proposal-analyzer.playground/Resources/
