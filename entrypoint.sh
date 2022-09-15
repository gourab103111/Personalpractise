#!/bin/bash

hub release create -a ./test1-release.apk -m "v${GITHUB_REF##*/}" ${GITHUB_REF##*/} 
