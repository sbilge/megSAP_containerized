#!/bin/bash
# Need to add -e flag due to outdated docker version in https://github.com/tehranian/dind-jenkins-slave
docker login -u ${REGISTRY_USER} -e ${REGISTRY_USER} -p ${REGISTRY_PASS} registry.gitlab.com
docker push registry.gitlab.com/clinicalreporting/megsap_containerized:latest
docker logout registry.gitlab.com
