# megSAP Containerized
This is a containerized version of the [Medical Genetics Sequence Analysis Pipeline](https://github.com/imgag/megSAP).

# USAGE
1. To run the container interactively (replace YOUR_VOLUME with a path on your host to store the downloads and results):

`docker run -i megsap_containerized -m "-v <YOUR VOLUME>:/mnt/data -v <YOUR VOLUME 2>:/tmp"`

2. To download the reference genome:

`cd megSAP/data/`

`./download_GRCh37.sh`

3. To download databases:

`./download_dbs.sh`

4. To run somatic_dna pipeline:

`cd mnt/data/`

`php /megSAP/src/Pipelines/somatic_dna.php -p_folder <PATH TO THE FOLDER CONTAINING SAMPLE FOLDERS> -t_id <TUMOUR SAMPLE PROCESSING ID> -n_id <NORMAL SAMPLE PROCESSSING ID> -t_sys <TUMOUR PROCESSING INI FILE> -n_sys <REFERENCE PROCESSING INI FILE> -o_folder <OUTPUT FOLDER>`

