#!/bin/bash
#comments11
#hub release create -a ./test1-release.apk -m "v${GITHUB_REF##*/}" ${GITHUB_REF##*/} 
hub checkout ${${REPO_BRANCH}:-master}
VERSION_NAME=`grep -oP 'versionName "\K(.*?)(?=")' ./${APP_FOLDER}/build.gradle`
hub release create -a ./app/build/outputs/apk/debug/app-debug.apk -m "${RELEASE_TITLE} - v${VERSION_NAME}" $(date +%Y%m%d%H%M%S)
