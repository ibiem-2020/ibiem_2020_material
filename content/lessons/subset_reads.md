``` r
library(tools)
library(tibble)
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(readr)
library(fs)
```

``` r
# Directories
data.dir = "/data/tutorial_data/ibiem_2016_lemur_data"
subset.dir = file.path("/data/tutorial_data/ibiem2016_subset")

# make directory for output
file_chmod(path_dir(subset.dir), "u+w")
dir.create(subset.dir, recursive = TRUE)
```

    ## Warning in dir.create(subset.dir, recursive = TRUE): '/data/tutorial_data/
    ## ibiem2016_subset' already exists

``` r
# Set variables for bash
Sys.setenv(DATA_DIR = data.dir)
Sys.setenv(SUBSET_DIR = subset.dir)
```

Check Data Integrity
--------------------

``` bash
cd $DATA_DIR
md5sum -c md5sum.txt
```

    ## ibiem_2017_map_v1.txt: OK
    ## ibiem_2017_map_v2.txt: OK
    ## ibiem_2017_map_v3_decoder.csv: OK
    ## ibiem_2017_map_v3.txt: OK
    ## Undetermined_S0_L001_I1_001.fastq.gz: OK
    ## Undetermined_S0_L001_R1_001.fastq.gz: OK
    ## Undetermined_S0_L001_R2_001.fastq.gz: OK

Generate Data Subset for Demo Purposes
--------------------------------------

``` bash
set -u
NUM_READS=20000
RANDSEED=1
for FASTQ_FULL in $DATA_DIR/*.gz ; do
  echo $FASTQ_FULL
  FASTQ_BASE=`basename $FASTQ_FULL`
  echo $FASTQ_BASE
  seqtk sample -s $RANDSEED $FASTQ_FULL $NUM_READS | gzip -c > $SUBSET_DIR/$FASTQ_BASE
  # zcat $SUBSET_DIR/$FASTQ_BASE | wc
done
```

    ## /data/tutorial_data/ibiem_2016_lemur_data/Undetermined_S0_L001_I1_001.fastq.gz
    ## Undetermined_S0_L001_I1_001.fastq.gz
    ## /data/tutorial_data/ibiem_2016_lemur_data/Undetermined_S0_L001_R1_001.fastq.gz
    ## Undetermined_S0_L001_R1_001.fastq.gz
    ## /data/tutorial_data/ibiem_2016_lemur_data/Undetermined_S0_L001_R2_001.fastq.gz
    ## Undetermined_S0_L001_R2_001.fastq.gz

Copy metadata to subset directory
=================================

``` r
map.file = file.path(data.dir,"ibiem_2017_map_v3.txt")
decoder.file = file.path(data.dir,"ibiem_2017_map_v3_decoder.csv")

file.copy(map.file, subset.dir)
```

    ## [1] FALSE

``` r
file.copy(decoder.file, subset.dir)
```

    ## [1] FALSE

Generate md5sums for subset directory
=====================================

``` r
md5sum(files = list.files(subset.dir,full.names = TRUE)) %>%
  as.data.frame %>%
  rownames_to_column(var="path") %>%
  mutate(path=basename(path)) %>%
  select(".",path) %>%
  write_delim(file.path(subset.dir,"md5sum.txt"), col_names = FALSE)
```

``` r
file_chmod(subset.dir, "a-w")
```

Session Info
============

Always print `sessionInfo` for reproducibility!

``` r
sessionInfo()
```

    ## R version 3.6.2 (2019-12-12)
    ## Platform: x86_64-pc-linux-gnu (64-bit)
    ## Running under: Ubuntu 18.04.3 LTS
    ## 
    ## Matrix products: default
    ## BLAS:   /usr/lib/x86_64-linux-gnu/blas/libblas.so.3.7.1
    ## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.7.1
    ## 
    ## locale:
    ##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
    ##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
    ##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8   
    ##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                 
    ##  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
    ## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       
    ## 
    ## attached base packages:
    ## [1] tools     stats     graphics  grDevices utils     datasets  methods  
    ## [8] base     
    ## 
    ## other attached packages:
    ## [1] fs_1.3.1     readr_1.3.1  dplyr_0.8.3  tibble_2.1.3
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] Rcpp_1.0.3       knitr_1.27       magrittr_1.5     hms_0.5.3       
    ##  [5] tidyselect_0.2.5 R6_2.4.1         rlang_0.4.2      stringr_1.4.0   
    ##  [9] xfun_0.12        htmltools_0.4.0  yaml_2.2.0       digest_0.6.23   
    ## [13] assertthat_0.2.1 crayon_1.3.4     purrr_0.3.3      vctrs_0.2.1     
    ## [17] zeallot_0.1.0    glue_1.3.1       evaluate_0.14    rmarkdown_2.1   
    ## [21] stringi_1.4.5    compiler_3.6.2   pillar_1.4.3     backports_1.1.5 
    ## [25] pkgconfig_2.0.3
