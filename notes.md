# NVMe benchmarking commands

## Questions

- Which region do we use - London or Ireland? (don't want to block other things for the dev team)
- Which Nextflow version do we use - `22.10.5`?
- Instance types:
    - For Fusion V2 + NVME -> `"instanceTypes" : [ "c6id", "m6id", "r6id" ]`
    - Everything else -> `"instanceTypes" : [ "c6i", "m6i", "r6i" ]`
- `"type" : "EC2"` in the JSON for on-demand CEs
- Priority of runs: Fusion V2 -> Fusion V2 + NVME -> FSx (scratch = true) -> FSx (scratch = false) -> S3
- S3 + FSx scratch default + FSX scratch false + Fusion v2 + Fusion v2 NVMe
- Use latest version of nf-core/rnaseq?
- Run minimal test

## nf-core/rnaseq

### Add pipeline to Workspace

```
tw pipelines import --workspace=seqeralabs/scidev-nvme-benchmarks --compute-env=fusionv2-test --name=nf-core-rnaseq-test-full nf-core-rnaseq-test-full.json
```

### Fusion V2

#### Add CE to Workspace

```
tw compute-envs import --workspace=seqeralabs/scidev-nvme-benchmarks --credentials=AWS_Seqera_Dev_Account_Creds --name=rnaseq-fusionv2-norl rnaseq-fusionv2.json
```

#### Resource labels

```
scidev-benchmarking=rnaseq-fusionv2-round7
scidev-benchmarking=rnaseq-fusionv2-round8
scidev-benchmarking=rnaseq-fusionv2-round9
```

#### Launch pipelines

```
tw launch --workspace=seqeralabs/scidev-nvme-benchmarks --work-dir='s3://scidev-eu-west-1' --params-file=<(echo -e "outdir: 's3://scidev-eu-west-1/results/rnaseq-fusionv2/round7'") --compute-env=rnaseq-fusionv2-round7 nf-core-rnaseq-test-full
tw launch --workspace=seqeralabs/scidev-nvme-benchmarks --work-dir='s3://scidev-eu-west-1' --params-file=<(echo -e "outdir: 's3://scidev-eu-west-1/results/rnaseq-fusionv2/round8'") --compute-env=rnaseq-fusionv2-round8 nf-core-rnaseq-test-full
tw launch --workspace=seqeralabs/scidev-nvme-benchmarks --work-dir='s3://scidev-eu-west-1' --params-file=<(echo -e "outdir: 's3://scidev-eu-west-1/results/rnaseq-fusionv2/round9'") --compute-env=rnaseq-fusionv2-round9 nf-core-rnaseq-test-full
```

### Fusion V2 + NVMe

#### Add CE to Workspace

```
tw compute-envs import --workspace=seqeralabs/scidev-nvme-benchmarks --credentials=AWS_Seqera_Dev_Account_Creds --name=rnaseq-fusionv2nvme-norl rnaseq-fusionv2nvme.json
```

#### Resource labels

```
scidev-benchmarking=rnaseq-fusionv2nvme-round7
scidev-benchmarking=rnaseq-fusionv2nvme-round8
scidev-benchmarking=rnaseq-fusionv2nvme-round9
```

#### Launch pipelines

```
tw launch --workspace=seqeralabs/scidev-nvme-benchmarks --work-dir='s3://scidev-eu-west-1' --params-file=<(echo -e "outdir: 's3://scidev-eu-west-1/results/rnaseq-fusionv2nvme/round7'") --compute-env=rnaseq-fusionv2nvme-round7 nf-core-rnaseq-test-full
tw launch --workspace=seqeralabs/scidev-nvme-benchmarks --work-dir='s3://scidev-eu-west-1' --params-file=<(echo -e "outdir: 's3://scidev-eu-west-1/results/rnaseq-fusionv2nvme/round8'") --compute-env=rnaseq-fusionv2nvme-round8 nf-core-rnaseq-test-full
tw launch --workspace=seqeralabs/scidev-nvme-benchmarks --work-dir='s3://scidev-eu-west-1' --params-file=<(echo -e "outdir: 's3://scidev-eu-west-1/results/rnaseq-fusionv2nvme/round9'") --compute-env=rnaseq-fusionv2nvme-round9 nf-core-rnaseq-test-full
```

### Fusion V2 + NVMe + Groundswell

#### Add CE to Workspace

```
tw compute-envs import --workspace=seqeralabs/scidev-nvme-benchmarks --credentials=AWS_Seqera_Dev_Account_Creds --name=rnaseq-fusionv2nvme-groundswell-norl rnaseq-fusionv2nvme-groundswell.json
```

#### Resource labels

```
scidev-benchmarking=rnaseq-fusionv2nvme-groundswell-round1
scidev-benchmarking=rnaseq-fusionv2nvme-groundswell-round2
scidev-benchmarking=rnaseq-fusionv2nvme-groundswell-round3
```

#### Launch pipelines

```
tw launch --workspace=seqeralabs/scidev-nvme-benchmarks --work-dir='s3://scidev-eu-west-1' --params-file=<(echo -e "outdir: 's3://scidev-eu-west-1/results/rnaseq-fusionv2nvme-groundswell/round1'") --config /home/harshil/testing/tw/tw_nvme/json/pipelines/nf-core-rnaseq-test-full-groundswell.config --compute-env=rnaseq-fusionv2nvme-groundswell-round1 nf-core-rnaseq-test-full
tw launch --workspace=seqeralabs/scidev-nvme-benchmarks --work-dir='s3://scidev-eu-west-1' --params-file=<(echo -e "outdir: 's3://scidev-eu-west-1/results/rnaseq-fusionv2nvme-groundswell/round2'") --config /home/harshil/testing/tw/tw_nvme/json/pipelines/nf-core-rnaseq-test-full-groundswell.config --compute-env=rnaseq-fusionv2nvme-groundswell-round2 nf-core-rnaseq-test-full
tw launch --workspace=seqeralabs/scidev-nvme-benchmarks --work-dir='s3://scidev-eu-west-1' --params-file=<(echo -e "outdir: 's3://scidev-eu-west-1/results/rnaseq-fusionv2nvme-groundswell/round3'") --config /home/harshil/testing/tw/tw_nvme/json/pipelines/nf-core-rnaseq-test-full-groundswell.config --compute-env=rnaseq-fusionv2nvme-groundswell-round3 nf-core-rnaseq-test-full
```

### Plain S3

#### Add CE to Workspace

```
tw compute-envs import --workspace=seqeralabs/scidev-nvme-benchmarks --credentials=AWS_Seqera_Dev_Account_Creds --name=rnaseq-s3-norl rnaseq-s3.json
```

#### Resource labels

```
scidev-benchmarking=rnaseq-s3-round7
scidev-benchmarking=rnaseq-s3-round8
scidev-benchmarking=rnaseq-s3-round9
```

#### Launch pipelines

```
tw launch --workspace=seqeralabs/scidev-nvme-benchmarks --work-dir='s3://scidev-eu-west-1' --params-file=<(echo -e "outdir: 's3://scidev-eu-west-1/results/rnaseq-s3/round7'") --compute-env=rnaseq-s3-round7 nf-core-rnaseq-test-full
tw launch --workspace=seqeralabs/scidev-nvme-benchmarks --work-dir='s3://scidev-eu-west-1' --params-file=<(echo -e "outdir: 's3://scidev-eu-west-1/results/rnaseq-s3/round8'") --compute-env=rnaseq-s3-round8 nf-core-rnaseq-test-full
tw launch --workspace=seqeralabs/scidev-nvme-benchmarks --work-dir='s3://scidev-eu-west-1' --params-file=<(echo -e "outdir: 's3://scidev-eu-west-1/results/rnaseq-s3/round9'") --compute-env=rnaseq-s3-round9 nf-core-rnaseq-test-full
```

### FSx (scratch = true)

#### Add CE to Workspace

```
tw compute-envs import --workspace=seqeralabs/scidev-nvme-benchmarks --credentials=AWS_Seqera_Dev_Account_Creds --name=rnaseq-fsx-scratch-norl rnaseq-fsx.json
```

#### Resource labels

```
scidev-benchmarking=rnaseq-fsx-scratch-round1
scidev-benchmarking=rnaseq-fsx-scratch-round2
scidev-benchmarking=rnaseq-fsx-scratch-round3
```

#### Launch pipelines

```
tw launch --workspace=seqeralabs/scidev-nvme-benchmarks --work-dir='/fsx/work' --params-file=<(echo -e "outdir: '/fsx/results/rnaseq-fsx/round1'") --compute-env=rnaseq-fsx-scratch-round1 nf-core-rnaseq-test-full
tw launch --workspace=seqeralabs/scidev-nvme-benchmarks --work-dir='/fsx/work' --params-file=<(echo -e "outdir: '/fsx/results/rnaseq-fsx/round2'") --compute-env=rnaseq-fsx-scratch-round2 nf-core-rnaseq-test-full
tw launch --workspace=seqeralabs/scidev-nvme-benchmarks --work-dir='/fsx/work' --params-file=<(echo -e "outdir: '/fsx/results/rnaseq-fsx/round3'") --compute-env=rnaseq-fsx-scratch-round3 nf-core-rnaseq-test-full
```

### FSx (scratch = false)

#### Add CE to Workspace

```
tw compute-envs import --workspace=seqeralabs/scidev-nvme-benchmarks --credentials=AWS_Seqera_Dev_Account_Creds --name=rnaseq-fsx-noscratch-norl rnaseq-fsx.json
```

#### Resource labels

```
scidev-benchmarking=rnaseq-fsx-noscratch-round1
scidev-benchmarking=rnaseq-fsx-noscratch-round2
scidev-benchmarking=rnaseq-fsx-noscratch-round3
```

#### Launch pipelines

```
tw launch --workspace=seqeralabs/scidev-nvme-benchmarks --work-dir='/fsx/work' --params-file=<(echo -e "outdir: '/fsx/results/rnaseq-fsx/round1'") --config=<(echo "process.scratch = false\nprocess.beforeScript = 'rm -rf *'") --compute-env=rnaseq-fsx-noscratch-round1 nf-core-rnaseq-test-full
tw launch --workspace=seqeralabs/scidev-nvme-benchmarks --work-dir='/fsx/work' --params-file=<(echo -e "outdir: '/fsx/results/rnaseq-fsx/round2'") --config=<(echo "process.scratch = false\nprocess.beforeScript = 'rm -rf *'") --compute-env=rnaseq-fsx-noscratch-round2 nf-core-rnaseq-test-full
tw launch --workspace=seqeralabs/scidev-nvme-benchmarks --work-dir='/fsx/work' --params-file=<(echo -e "outdir: '/fsx/results/rnaseq-fsx/round3'") --config=<(echo "process.scratch = false\nprocess.beforeScript = 'rm -rf *'") --compute-env=rnaseq-fsx-noscratch-round3 nf-core-rnaseq-test-full
```

### Fusion V1

#### Add CE to Workspace

```
tw compute-envs import --workspace=seqeralabs/scidev-nvme-benchmarks --credentials=AWS_Seqera_Dev_Account_Creds --name=rnaseq-fusionv1-norl rnaseq-fusionv1.json
```

#### Resource labels

```
scidev-benchmarking=rnaseq-fusionv1-round1
scidev-benchmarking=rnaseq-fusionv1-round2
scidev-benchmarking=rnaseq-fusionv1-round3
```

#### Launch pipelines

```
tw launch --workspace=seqeralabs/scidev-nvme-benchmarks --work-dir='s3://scidev-eu-west-1' --params-file=<(echo -e "outdir: 's3://scidev-eu-west-1/results/rnaseq-fusionv1/round1'") --compute-env=rnaseq-fusionv1-round1 nf-core-rnaseq-test-full
tw launch --workspace=seqeralabs/scidev-nvme-benchmarks --work-dir='s3://scidev-eu-west-1' --params-file=<(echo -e "outdir: 's3://scidev-eu-west-1/results/rnaseq-fusionv1/round2'") --compute-env=rnaseq-fusionv1-round2 nf-core-rnaseq-test-full
tw launch --workspace=seqeralabs/scidev-nvme-benchmarks --work-dir='s3://scidev-eu-west-1' --params-file=<(echo -e "outdir: 's3://scidev-eu-west-1/results/rnaseq-fusionv1/round3'") --compute-env=rnaseq-fusionv1-round3 nf-core-rnaseq-test-full
```

































## nf-core/sarek

### Add Compute Environments to Workspace

```
tw compute-envs import --workspace=seqeralabs/scidev-nvme-benchmarks --credentials=AWS_Seqera_Dev_Account_Creds --name=sarek-env1-s3-norl sarek-env1-s3.json
tw compute-envs import --workspace=seqeralabs/scidev-nvme-benchmarks --credentials=AWS_Seqera_Dev_Account_Creds --name=sarek-env2-fsx-norl sarek-env2-fsx.json
tw compute-envs import --workspace=seqeralabs/scidev-nvme-benchmarks --credentials=AWS_Seqera_Dev_Account_Creds --name=sarek-env3-fusionv2nvme-norl sarek-env3-fusionv2nvme.json
tw compute-envs import --workspace=seqeralabs/scidev-nvme-benchmarks --credentials=AWS_Seqera_Dev_Account_Creds --name=sarek-env4-fusionv2-norl sarek-env4-fusionv2.json
tw compute-envs import --workspace=seqeralabs/scidev-nvme-benchmarks --credentials=AWS_Seqera_Dev_Account_Creds --name=sarek-env5-fusionv1-norl sarek-env5-fusionv1.json
```

Once the environments above have been added we need to clone them and set the appropriate resource labels:

```
scidev-benchmarking=sarek-env1-s3-round3
scidev-benchmarking=sarek-env2-fsxx-round6
scidev-benchmarking=sarek-env3-fusionv2nvme-round4
scidev-benchmarking=sarek-env4-fusionv2-round3
scidev-benchmarking=sarek-env5-fusionv1-round3
```

- Activate NVMe option manually for NVMe environment
- EBS auto-scale has to be on for all environments except NVMe
- Set boot disk size to 100G for NVMe environment

### Add pipeline to Workspace

```
tw pipelines import --workspace=seqeralabs/scidev-nvme-benchmarks --compute-env=sarek-env1-s3 --name=hello_world hello_world.json
tw pipelines import --workspace=seqeralabs/scidev-nvme-benchmarks --compute-env=sarek-env1-s3 --name=nf-core-sarek-test-full nf-core-sarek-test-full.json
```

### Launch pipeline

```
tw launch --workspace=seqeralabs/scidev-nvme-benchmarks --work-dir='s3://scidev-eu-west-1' --params-file=<(echo -e "outdir: 's3://scidev-eu-west-1/results/sarek-env1-s3/round3'") --compute-env=sarek-env1-s3 nf-core-sarek-test-full
tw launch --workspace=seqeralabs/scidev-nvme-benchmarks --work-dir='/fsx/work' --params-file=<(echo -e "outdir: '/fsx/results/sarek-env2-fsx/round6'") --compute-env=sarek-env2-fsx nf-core-sarek-test-full
tw launch --workspace=seqeralabs/scidev-nvme-benchmarks --work-dir='s3://scidev-eu-west-1' --params-file=<(echo -e "outdir: 's3://scidev-eu-west-1/results/sarek-env3-fusionv2nvme/round4'") --compute-env=sarek-env3-fusionv2nvme nf-core-sarek-test-full
tw launch --workspace=seqeralabs/scidev-nvme-benchmarks --work-dir='s3://scidev-eu-west-1' --params-file=<(echo -e "outdir: 's3://scidev-eu-west-1/results/sarek-env4-fusionv2/round3'") --compute-env=sarek-env4-fusionv2 nf-core-sarek-test-full
tw launch --workspace=seqeralabs/scidev-nvme-benchmarks --work-dir='s3://scidev-eu-west-1' --params-file=<(echo -e "outdir: 's3://scidev-eu-west-1/results/sarek-env5-fusionv1/round3'") --compute-env=sarek-env5-fusionv1 nf-core-sarek-test-full
```

## Changes to defaults

- Added `export NXF_VER=22.08.2-edge` to Pre-run script in CE:

```
scidev-benchmarking=sarek-env2-fsxx-round4
scidev-benchmarking=rnaseq-env2-fsxx-round4
```

- Added `c6id`, `m6id` and `r6id` as Instance types in CE:

```
scidev-benchmarking=sarek-env3-fusionv2nvme-round5
scidev-benchmarking=sarek-env3-fusionv2nvme-round6
scidev-benchmarking=sarek-env3-fusionv2nvme-round7

scidev-benchmarking=rnaseq-env3-fusionv2nvme-round5
scidev-benchmarking=rnaseq-env3-fusionv2nvme-round6
scidev-benchmarking=rnaseq-env3-fusionv2nvme-round7
```

- Run with `NXF_VER=22.08.2-edge`

tw launch --workspace=seqeralabs/scidev-nvme-benchmarks --work-dir='/fsx/work' --params-file=<(echo -e "outdir: '/fsx/results/sarek-env2-fsx_22082edge/round1'") --pre-run <(echo "export NXF_VER=22.08.2-edge") --compute-env=sarek-env2-fsx_22082edge nf-core-sarek-test-full
tw launch --workspace=seqeralabs/scidev-nvme-benchmarks --work-dir='/fsx/work' --params-file=<(echo -e "outdir: '/fsx/results/rnaseq-env2-fsx_22082edge/round1'") --pre-run <(echo "export NXF_VER=22.08.2-edge") --compute-env=rnaseq-env2-fsx_22082edge nf-core-rnaseq-test-full 

## FSX resource labels that worked

```
tw compute-envs import --workspace=seqeralabs/scidev-nvme-benchmarks --credentials=AWS_Seqera_Dev_Account_Creds --name=sarek-env2-fsx-norl sarek-env2-fsx.json
tw compute-envs import --workspace=seqeralabs/scidev-nvme-benchmarks --credentials=AWS_Seqera_Dev_Account_Creds --name=rnaseq-env2-fsx-norl rnaseq-env2-fsx.json
```

## rounds

```
## RNASEQ
scidev-benchmarking=rnaseq-env2-fsxx-round20
scidev-benchmarking=rnaseq-env2-fsxx-round21
scidev-benchmarking=rnaseq-env2-fsxx-round22

tw launch --workspace=seqeralabs/scidev-nvme-benchmarks --work-dir='/fsx/work' --params-file=<(echo -e "outdir: '/fsx/results/rnaseq-env2-fsx/round20'") --pre-run=<(echo "export NXF_VER=23.01.1-SNAPSHOT") --config=<(echo "process.scratch = false\nprocess.beforeScript = 'rm -rf *'") --compute-env=rnaseq-env2-fsx-round20 nf-core-rnaseq-test-full
tw launch --workspace=seqeralabs/scidev-nvme-benchmarks --work-dir='/fsx/work' --params-file=<(echo -e "outdir: '/fsx/results/rnaseq-env2-fsx/round21'") --pre-run=<(echo "export NXF_VER=23.01.1-SNAPSHOT") --config=<(echo "process.scratch = false\nprocess.beforeScript = 'rm -rf *'") --compute-env=rnaseq-env2-fsx-round21 nf-core-rnaseq-test-full
tw launch --workspace=seqeralabs/scidev-nvme-benchmarks --work-dir='/fsx/work' --params-file=<(echo -e "outdir: '/fsx/results/rnaseq-env2-fsx/round22'") --pre-run=<(echo "export NXF_VER=23.01.1-SNAPSHOT") --config=<(echo "process.scratch = false\nprocess.beforeScript = 'rm -rf *'") --compute-env=rnaseq-env2-fsx-round22 nf-core-rnaseq-test-full

## SAREK: Coulnd't created resource label for scidev-benchmarking=sarek-env2-fsxx-round16 for some reason
scidev-benchmarking=sarek-env2-fsxx-round20
scidev-benchmarking=sarek-env2-fsxx-round21
scidev-benchmarking=sarek-env2-fsxx-round22

tw launch --workspace=seqeralabs/scidev-nvme-benchmarks --work-dir='/fsx/work' --params-file=<(echo -e "outdir: '/fsx/results/sarek-env2-fsx/round20'") --pre-run=<(echo "export NXF_VER=23.01.1-SNAPSHOT") --config=<(echo "process.scratch = false\nprocess.beforeScript = 'rm -rf *'") --compute-env=sarek-env2-fsx-round20 nf-core-sarek-test-full
tw launch --workspace=seqeralabs/scidev-nvme-benchmarks --work-dir='/fsx/work' --params-file=<(echo -e "outdir: '/fsx/results/sarek-env2-fsx/round21'") --pre-run=<(echo "export NXF_VER=23.01.1-SNAPSHOT") --config=<(echo "process.scratch = false\nprocess.beforeScript = 'rm -rf *'") --compute-env=sarek-env2-fsx-round21 nf-core-sarek-test-full
tw launch --workspace=seqeralabs/scidev-nvme-benchmarks --work-dir='/fsx/work' --params-file=<(echo -e "outdir: '/fsx/results/sarek-env2-fsx/round22'") --pre-run=<(echo "export NXF_VER=23.01.1-SNAPSHOT") --config=<(echo "process.scratch = false\nprocess.beforeScript = 'rm -rf *'") --compute-env=sarek-env2-fsx-round22 nf-core-sarek-test-full
```


tw \
    launch \
    --workspace=seqeralabs/scidev-nvme-benchmarks \
    --work-dir='/fsx/work' \
    --params-file=<(echo -e "outdir: '/fsx/results/rnaseq-env2-fsx/round20'") \
    --pre-run=<(echo "export NXF_VER=23.01.1-SNAPSHOT") \
    --config=<(echo "process.scratch = false\nprocess.beforeScript = 'rm -rf *'") \
    --compute-env=rnaseq-env2-fsx-round20 \
    nf-core-rnaseq-test-full
