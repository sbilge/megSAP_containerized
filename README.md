# megSAP Containerized
This is a containerized version of the [Medical Genetics Sequence Analysis Pipeline](https://github.com/imgag/megSAP).

# USAGE
## Initialise Databases

1. Download and normalize reference databases (replace YOUR_VOLUME with a path on your host to store the results)

```
docker run --workdir /megSAP/data -v YOUR_VOLUME:/data registry.gitlab.com/clinicalreporting/megsap_containerized /megSAP/data/download_hg19.sh /data
```
