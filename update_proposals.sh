#!/bin/bash

echo 'Updating swift-evolution submodule...'
git submodule update --remote

echo 'Copying proposals to playground Resources/ ...'
rm -rf swift-proposal-analyzer.playground/Resources/proposals/
cp -r swift-evolution/proposals/ swift-proposal-analyzer.playground/Resources/proposals/

./main.swift
