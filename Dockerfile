FROM debian:10.1

LABEL "version"="0.0.6"
LABEL "com.github.actions.name"="Release APK Publisher"
LABEL "com.github.actions.description"="Build & Publish Release APK on Github"
LABEL "com.github.actions.icon"="package"
LABEL "com.github.actions.color"="red"

LABEL "repository"="https://github.com/gourab103111/Personalpractise"
LABEL "maintainer"="gourab103111"

RUN apt update \
	&& apt -y upgrade \
	&& apt install -y hub \
	&& apt install nodejs \
	&& apt install npm \
	&& apt autoremove \
	&& apt autoclean \
	&& apt clean \
	&& install firebase-tools


ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

#FROM node:17-alpine3.14

#RUN yarn global add firebase-tools \
#    && apk update \
#    && apk add git 

#ADD firebaseentrypoint.sh /firebaseentrypoint.sh
#RUN chmod +x /firebaseentrypoint.sh
#ENTRYPOINT ["/firebaseentrypoint.sh"]	

