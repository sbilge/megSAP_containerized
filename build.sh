#!/bin/bash
docker info
docker build --pull -t registry.gitlab.com/clinicalreporting/megsap_containerized:latest .
