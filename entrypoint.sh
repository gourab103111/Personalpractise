#!/bin/bash
#comments11
#hub release create -a ./app/build/outputs/apk/release/app-release-unsigned.apk -m "v${GITHUB_REF##*/}" ${GITHUB_REF##*/} 
#hub checkout ${${REPO_BRANCH}:-master}
VERSION_NAME=`grep -oP 'versionName "\K(.*?)(?=")' ./${APP_FOLDER}/build.gradle`
hub release create -a ./app/build/outputs/apk/release/app-release.apk -m "${RELEASE_TITLE} - v${VERSION_NAME}" $(date +%Y%m%d%H%M%S)

# Required since https://github.blog/2022-04-12-git-security-vulnerability-announced
git config --global --add safe.directory $GITHUB_WORKSPACE

RELEASE_NOTES=""
RELEASE_NOTES_FILE=""

if [[ -z ${INPUT_RELEASENOTES} ]]; then
        RELEASE_NOTES="$(git log -1 --pretty=short)"
else
        RELEASE_NOTES=${INPUT_RELEASENOTES}
fi

if [[ ${INPUT_RELEASENOTESFILE} ]]; then
        RELEASE_NOTES=""
        RELEASE_NOTES_FILE=${INPUT_RELEASENOTESFILE}
fi

if [ -n "${INPUT_SERVICECREDENTIALSFILE}" ] ; then
    export GOOGLE_APPLICATION_CREDENTIALS="${INPUT_SERVICECREDENTIALSFILE}"
fi

if [ -n "${INPUT_TOKEN}" ] ; then
    export FIREBASE_TOKEN="${INPUT_TOKEN}"
fi

firebase \
        appdistribution:distribute \
        "$INPUT_FILE" \
        --app "$INPUT_APPID" \
        --groups "$INPUT_GROUPS" \
        ${RELEASE_NOTES:+ --release-notes "${RELEASE_NOTES}"} \
        ${INPUT_RELEASENOTESFILE:+ --release-notes-file "${RELEASE_NOTES_FILE}"} \
        $( (( $INPUT_DEBUG )) && printf %s '--debug' )


