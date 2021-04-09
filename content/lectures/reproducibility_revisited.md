Good
----

### Detailed instructions

1.  Download the data from . . .
2.  Download the Docker image from . . .
3.  Run Rmarkdown a.Rmd
4.  Run Rmarkdown b.Rmd
5.  Run Rmarkdown c.Rmd
6.  Run Rmarkdown d.Rmd
7.  Run Rmarkdown e.Rmd

Better
------

1.  A “meta” script to run all the analysis components
2.  Detailed instructions:
    1.  Download the data from . . .
    2.  Download the Docker image from . . .
    3.  Run Rmarkdown meta.Rmd

Best
----

### A “super-meta” script that does everything

### Detailed instructions

1.  Download the super-meta script with the command
    `wget https://raw.githubusercontent.com/ibiem-2020/ibiem_2020_material/master/content/misc/reproducibility_demo_slurm.sh`
2.  Run the super-meta script with the command
    `bash reproducibility_demo_slurm.sh [OUTPUT_DIR]`. For example:
    `bash reproducibility_demo_slurm.sh /work/josh/ibiem_repro_demo`
