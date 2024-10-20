#!/usr/bin/env bash

if [ $# -lt 1 ]; then
    printf "When running this script, please supply an output directory as a command line argument\n" >&2 
    printf "\n\nNOTE: Memory limitation can cause this to fail at the assignTaxonomy step.\n" >&2
    printf "This can be a problem if there is not enough memory on the host machine,\n" >&2
    printf "or if Docker is run with a memory cap. Docker Desktop on MacOS and Windows\n" >&2
    printf "seems to default to a value that is too low\n\n" >&2
    exit 1
fi

OUT_DIR=${1}
BASE_DIR="${OUT_DIR}/reproducible_demo_`date +%s`_tmp"

WORK_DIR="$BASE_DIR/work"
DATA_DIR="$BASE_DIR/data"
DOCKER_IMAGENAME="ibiem/docker_rstudio_ibiem2020"
SEP_STRING="\n--------------------------------------------------\n"

echo "Outputting to: $BASE_DIR"
mkdir -p $WORK_DIR $DATA_DIR

srun $2 git clone https://github.com/ibiem-2020/ibiem_2020_material.git  ${WORK_DIR}/demo


# printf "\n${SEP_STRING} Pulling docker image: $DOCKER_IMAGENAME ${SEP_STRING}"
# docker pull $DOCKER_IMAGENAME


printf "\n${SEP_STRING} STARTING Pipeline in Singularity ${SEP_STRING}"
# srun -A chsi -p chsi --mem=8G --cpus-per-task=10 singularity exec \
srun $2 --mem=8G --cpus-per-task=10 singularity exec \
  --bind ${WORK_DIR}:${HOME} \
  --bind ${DATA_DIR}:/data \
  docker://${DOCKER_IMAGENAME} \
  Rscript -e "rmarkdown::render('${HOME}/demo/content/lessons/run_everything.Rmd')"

printf "\n${SEP_STRING} FINISHED Pipeline ${SEP_STRING}"
printf "\n${SEP_STRING} Results output to ${WORK_DIR}/scratch\n\n"

printf "\n${SEP_STRING} To clean up: \n\n"
echo "chmod -R u+w $BASE_DIR"
echo "rm -rf $BASE_DIR"
# echo "docker rm -f \`docker ps -aq\`"
# echo "docker rmi \`docker images -aq\`"
printf "${SEP_STRING}\n"

