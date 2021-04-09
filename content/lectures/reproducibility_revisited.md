Remember . . .
==============

Three Pillars of Reproducible Analysis
--------------------------------------

-   Raw Data
-   Compute Environment
-   Analysis Process (Code)

Good
----

### Detailed instructions

1.  Download the **Data** from . . .
2.  Download the **Docker Image** from . . .
3.  Download the **Code** from . . .
4.  Run the following scripts in the order given:
    1.  Rmarkdown A.Rmd
    2.  Rmarkdown B.Rmd
    3.  Rmarkdown C.Rmd
    4.  Rmarkdown D.Rmd
    5.  Rmarkdown E.Rmd

Better
------

1.  A “meta” script to run all the analysis components
2.  Detailed instructions:
    1.  Download the **Data** from . . .
    2.  Download the **Docker Image** from . . .
    3.  Download the **Code** from . . .
    4.  Run Rmarkdown **meta.Rmd** using the Docker Image

Best
----

### A “super-meta” script that does everything

### Detailed instructions

1.  Download the super-meta script with the command
    `wget https://raw.githubusercontent.com/ibiem-2020/ibiem_2020_material/master/content/misc/reproducibility_demo_slurm.sh`
2.  Run the super-meta script with the command
    `bash reproducibility_demo_slurm.sh [OUTPUT_DIR]`. For example:
    `bash reproducibility_demo_slurm.sh /work/josh/ibiem_repro_demo`.
    This will automatically:
    1.  Download the **Data** from . . .
    2.  Download the **Docker Image** from . . .
    3.  Download the **Code** from . . .
    4.  Run Rmarkdown **meta.Rmd** using the Docker Image
