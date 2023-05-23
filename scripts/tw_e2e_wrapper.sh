#!/bin/bash

## GLOBAL VARIABLES

WORKSPACE='<TOWER_ORGANISATION>/<TOWER_WORKSPACE>'
WORK_DIR='gs://'

COMPUTE_ENVS_DIR=gcp/json/compute-envs
COMPUTE_ENVS=( test_gcp_uscentral1 )
DEFAULT_COMPUTE_ENV='test_gcp_uscentral1'

PIPELINES_DIR=gcp/json/pipelines
PIPELINES=( hello_world )

# TODO Adding a workspace with org provided as global variable?
# tw workspaces add --name=shared-workspace --full-name=shared-workspace-for-all  --org=$TOWER_ORGANISATION --visibility=SHARED

# TODO: Datasets
DATASET_DIR=gcp/datasets

# Import CE into Tower workspace

for i in "${COMPUTE_ENVS[@]}"
do
    if [ -f "$COMPUTE_ENVS_DIR/$i.json" ]; then
        tw compute-envs import --workspace=$WORKSPACE --name=$i --wait='AVAILABLE' "$COMPUTE_ENVS_DIR/$i.json"
    fi
done

# TODO Import dataset
# TODO Import/add labels?

# Import Pipelines into a Tower Workspace

for i in "${PIPELINES[@]}"
do
    if [ -f "$PIPELINES_DIR/$i.json" ]; then

        ## Set default Compute Environment
        COMPUTE_ENV=$DEFAULT_COMPUTE_ENV
        tw pipelines import --workspace=$WORKSPACE --name=$i --compute-env=$COMPUTE_ENV "$PIPELINES_DIR/$i.json"
    fi
done

# Export Pipelines from a Tower Workspace

# for i in "${PIPELINES[@]}"
# do
#     tw pipelines export --workspace=$WORKSPACE --name=$i > "$PIPELINES_DIR/$i.json"
# done


## Launch Pipelines in a Tower Workspace

for i in "${PIPELINES[@]}"
do
    tw launch --workspace=$WORKSPACE --params-file=<(echo -e "outdir: ${WORK_DIR}/$i") $i
done
